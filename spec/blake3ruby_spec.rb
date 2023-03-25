# frozen_string_literal: true

RSpec.describe Blake3ruby do
  let(:test_string) { "Hello World" }
  let(:test_content) { "My Context" }
  let(:test_string_hash) { "41f8394111eb713a22165c46c90ab8f0fd9399c92028fd6d288944b23ff5bf76" }
  let(:empty_string_hash) { "af1349b9f5f9a1a6a0404dea36dcc9499bcb25c9adc112b7cc9a93cae41f3262" }
  let(:derived_key) { "8d0d2f6f071f7fd8361c3f8044397b8fd2d8ee508a37398d6657c4e7edc790ad" }

  it "has a version number" do
    expect(Blake3ruby::VERSION).not_to be nil
  end

  it "has a Blake3ruby module" do
    expect(Blake3ruby).to be_a(Module)
  end

  it "responds to Blake3ruby.hexdigest method" do
    expect(Blake3ruby).to respond_to(:hexdigest)
  end

  it "calculate the correct hash" do
    expect(Blake3ruby.hexdigest(test_string)).to eq(test_string_hash)
  end

  it "calculate the correct hash with an empty string" do
    expect(Blake3ruby.hexdigest("")).to eq(empty_string_hash)
  end

  it "responds to Blake3ruby#derive_key method" do
    expect(Blake3ruby).to respond_to(:derive_key)
  end

  it "calculate the correct key with Blake3ruby#derive_key" do
    expect(Blake3ruby.derive_key(test_string, "My Context")).to eq(derived_key)
  end

  it "has a Blake3ruby::Hasher class" do
    expect(Blake3ruby::Hasher).to be_a(Class)
  end

  it "responds to Blake3ruby::Hasher#new method" do
    expect(Blake3ruby::Hasher).to respond_to(:new)
  end

  it "responds to Blake3ruby::Hasher#update method" do
    expect(Blake3ruby::Hasher.new).to respond_to(:update)
  end

  it "responds to Blake3ruby::Hasher#finallize method" do
    expect(Blake3ruby::Hasher.new).to respond_to(:finalize)
  end

  it "calculate the correct hash with Blake3ruby::Hasher" do
    hasher = Blake3ruby::Hasher.new
    hasher.update("Hello ")
    hasher.update("World")
    expect(hasher.finalize).to eq(test_string_hash)
  end
end
