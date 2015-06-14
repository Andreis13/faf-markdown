
require 'spec_helper'

describe FAF::Markdown::StarProcessor do

  it "uses star characters to form <strong> and <em> tags" do
    expect(
      subject.call(['aaa', '*', 'bbb', '*', 'ccc']).join
    ).to eq 'aaa<em>bbb</em>ccc'
    expect(
      subject.call(%w(aaa ** bbb **)).join
    ).to eq 'aaa<strong>bbb</strong>'
    expect(
      subject.call(%w(aaa ** bbb *)).join
    ).to eq 'aaa**bbb*'
    expect(
      subject.call(%w(a ** b * c ***)).join
    ).to eq 'a<strong>b<em>c</em></strong>'
  end

end
