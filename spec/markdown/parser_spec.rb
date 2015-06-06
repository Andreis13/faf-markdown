
require 'spec_helper'

describe FAF::Markdown::Parser do
  context 'public methods' do

    describe '#run' do
      it 'should respond to run' do
        expect { described_class.new("").run }.not_to raise_exception
      end
    end
  end

end
