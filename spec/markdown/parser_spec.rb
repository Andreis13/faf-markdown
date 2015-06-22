
require 'spec_helper'

describe FAF::Markdown::Parser do
  let(:subject) { described_class.new("") }

  context 'public methods' do

    describe '#run' do
      it 'should respond to run' do
        expect { described_class.new("").run }.not_to raise_exception
      end
    end
  end


  context 'private methods' do
    describe '#split_top_level' do
      it 'groups paragraph and heading lines' do
        expect(
          subject.send(:split_top_level, "a b c\n\ndef\n")
        ).to eq ["a b c", "def"]

        expect(
          subject.send(:split_top_level, "a b\nc\ndef")
        ).to eq ["a b\nc\ndef"]

        expect(
          subject.send(:split_top_level, "a bc\ndef")
        ).to eq ["a bc\ndef"]

        expect(
          subject.send(:split_top_level, "## a b\nc\ndef")
        ).to eq ["## a b", "c\ndef"]

        expect(
          subject.send(:split_top_level, "# a\n## a b\nc\ndef")
        ).to eq ["# a", "## a b", "c\ndef"]

        expect(
          subject.send(:split_top_level, "## a b\nc\ndef")
          ).to eq ["## a b", "c\ndef"]

        expect(
          subject.send(:split_top_level, "a\n\n\n\nc\ndef")
        ).to eq ["a", "c\ndef"]

        expect(
          subject.send(:split_top_level, "\n####ac\ndef")
        ).to eq ["####ac", "def"]

        expect(
          subject.send(:split_top_level, "### acdef")
        ).to eq ["### acdef"]

        expect(
          subject.send(:split_top_level, "###acdef")
        ).to eq ["###acdef"]

        expect(
          subject.send(:split_top_level, "###\nacdef")
        ).to eq ["###", "acdef"]

        expect(
          subject.send(:split_top_level, "   ### \nacdef")
        ).to eq ["   ### ", "acdef"]

        expect(
          subject.send(:split_top_level, "abc\n### arst")
        ).to eq ["abc", "### arst"]
      end
    end

    describe '#split_by_special_chars' do
      it 'splits the string given an array of special sequencies' do
        expect(
          subject.send(:split_by_special_chars, "arstart**ars", %w(**))
        ).to eq %w(arstart ** ars)

        expect(
          subject.send(:split_by_special_chars, "ar [st ]( ars) (  [ arst", %w([ ]( )))
        ).to eq ['ar ', '[', 'st ', '](', ' ars', ')', ' (  ', '[', ' arst']

        expect(
          subject.send(:split_by_special_chars, "cod`aa`", %w(`))
        ).to eq %w(cod ` aa `)

        expect(
          subject.send(:split_by_special_chars, "coarst", %w(` *))
        ).to eq %w(coarst)

        expect(
          subject.send(:split_by_special_chars, "***", %w(*))
        ).to eq %w(* * *)
      end
    end
  end

  describe 'parsing examples' do
    let(:sample_data) { {
      'some [text](url) other' => '<p>some <a href="url">text</a> other</p>',
      '**bold**'               => '<p><strong>bold</strong></p>',
      '*italic*'               => '<p><em>italic</em></p>',
      '`code`'                 => '<p><code>code</code></p>'
    } }

    it "should parse the keys and return the values" do
      sample_data.each do |key, value|
        expect(described_class.new(key).run).to eq value
      end
    end
  end

end
