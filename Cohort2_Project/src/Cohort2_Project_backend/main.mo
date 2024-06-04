import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Option "mo:base/Option";
import List "mo:base/List";
import Iter "mo:base/Iter";

actor TicketingApp {

  // Define a type for tickets
  type Ticket = {
    id : Text;
    description : Text;
    status : Text;
  };

  var tickets = HashMap.HashMap<Text, Ticket>(100, Text.equal, Text.hash);

  public func addTicket(id : Text, description : Text) {
    let newTicket = { id = id; description = description; status = "Open" };
    tickets.put(id, newTicket);
  };

  public func removeTicket(id : Text) {
    tickets.delete(id);
  };

  public func getTicket(id : Text) : async ?Ticket {
    tickets.get(id);
  };

  public func updateTicketStatus(id : Text, newStatus : Text) : async ?Ticket {
    switch (tickets.get(id)) {
      case (null) {
        null;
      };
      case (?ticket) {
        let updatedTicket = {
          id = ticket.id;
          description = ticket.description;
          status = newStatus;
        };
        tickets.put(id, updatedTicket);
        ?updatedTicket;
      };
    };
  };

  public func getAllTickets() : async [Ticket] {
    Iter.toArray<Ticket>(tickets.vals());
  };

  public func validateTicket(id : Text) : async Bool {
    switch (tickets.get(id)) {
      case (null) {
        false;
      };
      case (?ticket) {
        ticket.status == "Open";
      };
    };
  };
};