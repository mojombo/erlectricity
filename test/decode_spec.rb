require File.dirname(__FILE__) + '/test_helper.rb'

context "When unpacking from a binary stream" do
  setup do
  end
  
  specify "an erlang atom should decode to a ruby symbol" do
    get("haha").should == :haha
  end
  
  specify "an erlang number encoded as a small_int (< 255) should decode to a fixnum" do
    get("0").should == 0
    get("255").should == 255
  end
  
  specify "an erlang number encoded as a int (signed 27-bit number) should decode to a fixnum" do
    get("256").should == 256
    get("#{(1 << 27) -1}").should == (1 << 27) -1
    get("-1").should == -1
    get("#{-(1 << 27)}").should == -(1 << 27)
  end
  
  
  specify "an erlang number encoded as a small bignum (1 byte length) should decode to fixnum if it can" do
    get("#{(1 << 27)}").should == (1 << 27)
    get("#{-(1 << 27) - 1}").should == -(1 << 27) - 1
    get("#{(1 << word_length) - 1}").should == (1 << word_length) - 1
    get("#{-(1 << word_length)}").should == -(1 << word_length)
  end
  
  specify "an erlang number encoded as a small bignum (1 byte length) should decode to bignum if it can't be a fixnum" do
    get("#{(1 << word_length)}").should == (1 << word_length)
    get("#{-(1 << word_length) - 1}").should == -(1 << word_length) - 1
    get("#{(1 << (255 * 8)) - 1}").should == (1 << (255 * 8)) - 1
    get("#{-((1 << (255 * 8)) - 1)}").should == -((1 << (255 * 8)) - 1)
  end
  
  
  specify "an erlang number encoded as a big bignum (4 byte length) should decode to bignum" do
    get("#{(1 << (255 * 8)) }").should == (1 << (255 * 8))
    get("#{-(1 << (255 * 8))}").should == -(1 << (255 * 8))
    get("#{(1 << (512 * 8)) }").should == (1 << (512 * 8))
    get("#{-(1 << (512 * 8))}").should == -(1 << (512 * 8))
  end
  
  specify "an erlang float should decode to a Float" do
    get("#{1.0}").should == 1.0
    get("#{-1.0}").should == -1.0
    get("#{123.456}").should == 123.456
    get("#{123.456789012345}").should == 123.456789012345
  end
  
  
  specify "an erlang reference should decode to a Reference object" do
    ref = get("make_ref()")
    ref.should.be.instance_of Erlectricity::NewReference
    ref.node.should.be.instance_of Symbol
  end
  
  specify "an erlang pid should decode to a Pid object" do
    pid = get("spawn(fun() -> 3 end)")
    pid.should.be.instance_of Erlectricity::Pid
    pid.node.should.be.instance_of Symbol
  end
  
  
  specify "an erlang tuple encoded as a small tuple (1-byte length) should decode to an array" do
    ref = get("{3}")
    ref.length.should == 1
    ref.first.should == 3
  
    ref = get("{3, a, make_ref()}")
    ref.length.should == 3
    ref[0].should == 3
    ref[1].should == :a
    ref[2].class.should == Erlectricity::NewReference
  
    tuple_meat = (['3'] * 255).join(', ')
    ref = get("{#{tuple_meat}}")
    ref.length.should == 255
    ref.each{|r| r.should == 3}
  end
  
  
  specify "an erlang tuple encoded as a large tuple (4-byte length) should decode to an array" do
    tuple_meat = (['3'] * 256).join(', ')
    ref = get("{#{tuple_meat}}")
    ref.length.should == 256
    ref.each{|r| r.should == 3}
    
    tuple_meat = (['3'] * 512).join(', ')
    ref = get("{#{tuple_meat}}")
    ref.length.should == 512
    ref.each{|r| r.should == 3}
  end
  
  
  specify "an empty erlang list encoded as a nil should decode to an array" do
    get("[]").should == []
  end
  
  specify "an erlang list encoded as a string should decode to an array of bytes (less than ideal, but consistent)" do
    get("\"asdasd\"").should == "asdasd".split('').map{|c| c[0]}
    get("\"#{'a' * 65534}\"").should == ['a'[0]] * 65534
  end
  
  specify "an erlang list encoded as a list should decode to a array" do
    get("[3,4,256]").should == [3,4,256]
    get("\"#{'a' * 65535 }\"").should == [97] * 65535
    get("[3,4, foo, {3,4,5,bar}, 256]").should == [3,4, :foo, [3,4,5,:bar], 256]
  end
  
  
  specify "an erlang binary should decode to a string" do
    get("<< 3,4,255 >>").should == "\003\004\377"
    get("<< \"whatup\" >>").should == "whatup"
  end
  
  def get(str)
    bin = run_erl("term_to_binary(#{str})")
    Erlectricity::Decoder.read_any_from(bin)
  end
end