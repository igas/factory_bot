describe FactoryBot::Internal do
  describe ".register_trait" do
    it "registers the provided trait" do
      trait = FactoryBot::Trait.new(:admin)
      configuration = FactoryBot::Internal.configuration

      expect { FactoryBot::Internal.register_trait(trait) }.
        to change { configuration.traits.count }.
        from(0).
        to(1)
    end

    it "returns the registered trait" do
      trait = FactoryBot::Trait.new(:admin)

      expect(FactoryBot::Internal.register_trait(trait)).to eq trait
    end
  end

  describe ".trait_by_name" do
    it "finds a previously registered trait" do
      trait = FactoryBot::Trait.new(:admin)
      FactoryBot::Internal.register_trait(trait)

      expect(FactoryBot::Internal.trait_by_name(trait.name)).to eq trait
    end
  end

  describe ".register_sequence" do
    it "registers the provided sequence" do
      sequence = FactoryBot::Sequence.new(:email)
      configuration = FactoryBot::Internal.configuration

      expect { FactoryBot::Internal.register_sequence(sequence) }.
        to change { configuration.sequences.count }.
        from(0).
        to(1)
    end

    it "returns the registered sequence" do
      sequence = FactoryBot::Sequence.new(:email)

      expect(FactoryBot::Internal.register_sequence(sequence)).to eq sequence
    end
  end

  describe ".sequence_by_name" do
    it "finds a registered sequence" do
      sequence = FactoryBot::Sequence.new(:email)
      FactoryBot::Internal.register_sequence(sequence)

      expect(FactoryBot::Internal.sequence_by_name(sequence.name)).to eq sequence
    end
  end

  describe ".rewind_sequences" do
    it "rewinds the sequences and the internal sequences" do
      sequence = instance_double(FactoryBot::Sequence, names: ["email"])
      allow(sequence).to receive(:rewind)
      FactoryBot::Internal.register_sequence(sequence)

      inline_sequence = instance_double(FactoryBot::Sequence)
      allow(inline_sequence).to receive(:rewind)
      FactoryBot::Internal.register_inline_sequence(inline_sequence)

      FactoryBot::Internal.rewind_sequences

      expect(sequence).to have_received(:rewind).exactly(:once)
      expect(inline_sequence).to have_received(:rewind).exactly(:once)
    end
  end

  describe ".register_factory" do
    it "registers the provided factory" do
      factory = FactoryBot::Factory.new(:object)
      configuration = FactoryBot::Internal.configuration

      expect { FactoryBot::Internal.register_factory(factory) }.
        to change { configuration.factories.count }.
        from(0).
        to(1)
    end

    it "returns the registered factory" do
      factory = FactoryBot::Factory.new(:object)

      expect(FactoryBot::Internal.register_factory(factory)).to eq factory
    end
  end

  describe ".factory_by_name" do
    it "finds a registered factory" do
      factory = FactoryBot::Factory.new(:object)
      FactoryBot::Internal.register_factory(factory)

      expect(FactoryBot::Internal.factory_by_name(factory.name)).to eq factory
    end
  end
end