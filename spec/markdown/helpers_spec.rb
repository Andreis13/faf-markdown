
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
        .to eq 'href="some" title="other"'
    end
  end

  describe '#split_top_level' do
    it 'groups paragraph and heading lines' do
      expect(
        obj.split_top_level "a b c\n\ndef\n"
      ).to eq ["a b c", "def"]

      expect(
        obj.split_top_level "a b\nc\ndef"
      ).to eq ["a b\nc\ndef"]

      expect(
        obj.split_top_level "a bc\ndef"
      ).to eq ["a bc\ndef"]

      expect(
        obj.split_top_level "## a b\nc\ndef"
      ).to eq ["## a b", "c\ndef"]

      expect(
        obj.split_top_level "# a\n## a b\nc\ndef"
      ).to eq ["# a", "## a b", "c\ndef"]

      expect(
        obj.split_top_level "## a b\nc\ndef"
        ).to eq ["## a b", "c\ndef"]

      expect(
        obj.split_top_level "a\n\n\n\nc\ndef"
      ).to eq ["a", "c\ndef"]

      expect(
        obj.split_top_level "\n####ac\ndef"
      ).to eq ["####ac\ndef"]

      expect(
        obj.split_top_level "### acdef"
      ).to eq ["### acdef"]

      expect(
        obj.split_top_level "###acdef"
      ).to eq ["###acdef"]

      expect(
        obj.split_top_level "###\nacdef"
      ).to eq ["###\nacdef"]

      expect(
        obj.split_top_level "   ### \nacdef"
      ).to eq ["   ### \nacdef"]

      expect(
        obj.split_top_level "abc\n### arst"
      ).to eq ["abc", "### arst"]
    end
  end
end
