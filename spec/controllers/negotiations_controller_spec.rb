require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe NegotiationsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Negotiation. As you add validations to Negotiation, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # NegotiationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all negotiations as @negotiations" do
      negotiation = Negotiation.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:negotiations)).to eq([negotiation])
    end
  end

  describe "GET show" do
    it "assigns the requested negotiation as @negotiation" do
      negotiation = Negotiation.create! valid_attributes
      get :show, {:id => negotiation.to_param}, valid_session
      expect(assigns(:negotiation)).to eq(negotiation)
    end
  end

  describe "GET new" do
    it "assigns a new negotiation as @negotiation" do
      get :new, {}, valid_session
      expect(assigns(:negotiation)).to be_a_new(Negotiation)
    end
  end

  describe "GET edit" do
    it "assigns the requested negotiation as @negotiation" do
      negotiation = Negotiation.create! valid_attributes
      get :edit, {:id => negotiation.to_param}, valid_session
      expect(assigns(:negotiation)).to eq(negotiation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Negotiation" do
        expect {
          post :create, {:negotiation => valid_attributes}, valid_session
        }.to change(Negotiation, :count).by(1)
      end

      it "assigns a newly created negotiation as @negotiation" do
        post :create, {:negotiation => valid_attributes}, valid_session
        expect(assigns(:negotiation)).to be_a(Negotiation)
        expect(assigns(:negotiation)).to be_persisted
      end

      it "redirects to the created negotiation" do
        post :create, {:negotiation => valid_attributes}, valid_session
        expect(response).to redirect_to(Negotiation.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved negotiation as @negotiation" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Negotiation).to receive(:save).and_return(false)
        post :create, {:negotiation => {  }}, valid_session
        expect(assigns(:negotiation)).to be_a_new(Negotiation)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Negotiation).to receive(:save).and_return(false)
        post :create, {:negotiation => {  }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested negotiation" do
        negotiation = Negotiation.create! valid_attributes
        # Assuming there are no other negotiations in the database, this
        # specifies that the Negotiation created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Negotiation).to receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => negotiation.to_param, :negotiation => { "these" => "params" }}, valid_session
      end

      it "assigns the requested negotiation as @negotiation" do
        negotiation = Negotiation.create! valid_attributes
        put :update, {:id => negotiation.to_param, :negotiation => valid_attributes}, valid_session
        expect(assigns(:negotiation)).to eq(negotiation)
      end

      it "redirects to the negotiation" do
        negotiation = Negotiation.create! valid_attributes
        put :update, {:id => negotiation.to_param, :negotiation => valid_attributes}, valid_session
        expect(response).to redirect_to(negotiation)
      end
    end

    describe "with invalid params" do
      it "assigns the negotiation as @negotiation" do
        negotiation = Negotiation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Negotiation).to receive(:save).and_return(false)
        put :update, {:id => negotiation.to_param, :negotiation => {  }}, valid_session
        expect(assigns(:negotiation)).to eq(negotiation)
      end

      it "re-renders the 'edit' template" do
        negotiation = Negotiation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Negotiation).to receive(:save).and_return(false)
        put :update, {:id => negotiation.to_param, :negotiation => {  }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested negotiation" do
      negotiation = Negotiation.create! valid_attributes
      expect {
        delete :destroy, {:id => negotiation.to_param}, valid_session
      }.to change(Negotiation, :count).by(-1)
    end

    it "redirects to the negotiations list" do
      negotiation = Negotiation.create! valid_attributes
      delete :destroy, {:id => negotiation.to_param}, valid_session
      expect(response).to redirect_to(negotiations_url)
    end
  end

end
