class ContactsController < ApplicationController

	def index
		@contact = Contact.new
		@user = current_user
		gon.user_contacts = @user.contacts
	end

	def create
		@contact = Contact.new(contact_params)
		@contact.save
	end

	private
	def contact_params
		params.require(:contact).permit(:user_id, :title, :body, :mail, :reply)
	end
end
