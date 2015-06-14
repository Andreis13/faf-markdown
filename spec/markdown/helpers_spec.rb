
require 'spec_helper'

describe FAF::Markdown::Helpers do
  let(:obj) { Class.new { include FAF::Markdown::Helpers }.new }

  describe '#content_tag' do
    it 'creates a string repersentation of a tag' do
      expect( obj.content_tag(:i, 'text')   ).to eq '<i>text</i>'

      expect( obj.content_tag('p', 'some')  ).to eq '<p>some</p>'
      expect( obj.content_tag('h3', '')     ).to eq '<h3></h3>'
      expect( obj.content_tag('div')        ).to eq '<div></div>'

      expect( obj.content_tag('code', obj.content_tag('strong')) )
        .to eq '<code><strong></strong></code>'
    end
  end

  describe '#tag_option' do
    it 'makes a string out of a key-value pair' do
      expect( obj.tag_option('href', 'some')).to eq 'href="some"'
      expect( obj.tag_option('attr', %w(a b))).to eq 'attr="a b"'
    end
  end

  describe '#tag_options' do
    it 'stringifies a hash of attributes' do
      expect( obj.tag_options(:href => 'some', :title => 'other'))
        .to eq ' href="some" title="other"'
    end
  end


end
