describe PageController do

  subject { PageController.new(dummy_id) }

  describe PageController, '#domain' do
    it 'should raise a NotImplementedError' do
      expect { subject.domain }.to raise_error(NotImplementedError)
    end
  end

  describe PageController, '#page' do
    it 'should return a Hash with the passed key and subject and :domain with the return of domain' do
      subject.stub(:domain) { :domain_value }

      relation = double('relation')
      relation.stub(:objects)

      subject_value = double('subject')
      subject_value.stub(:relations) { { :relation => relation }  }

      page = subject.page( :subject_key, subject_value )

      page.should have_key(:subject_key)
      page.should have_key(:domain)

      page[:subject_key].should == subject_value
      page[:domain].should == :domain_value
    end

    it 'should call each on the relations attribute of the passed subject' do
      subject.stub(:domain) { :domain_value }

      relation = double('relation')
      relation.stub(:objects)

      relations = double('relations')
      relations.should_receive(:each).and_return({ :relation => relation })

      subject_value = double('subject')
      subject_value.stub(:relations) { relations }

      subject.page( :subject_key, subject_value )
    end
  end

  describe PageController, "#initialize" do
    it 'should accept and set an event ID' do
      subject.id.should == dummy_id
    end

    it 'should set builder as an instance of Builder' do
      subject.builder.should be_an_instance_of(Builder)
    end
  end

end
