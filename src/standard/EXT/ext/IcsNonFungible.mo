
import Text "mo:base/Text";
import Nat8 "mo:base/Nat8";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Bool "mo:base/Bool";
import Result "mo:base/Result";
import ExtCore "./Core";
import ExtCommon "./Common";
import ExtTransactions "./Transactions";

module IcsNonFungible = {

  public type Remark = Text;

  public type KVPair = {
      k : Text; 
      v : Text;
  };

  public type MintRequest = {
      nftType : Text;
      fileType : Text;
      artistName : Text;
      introduction : Text;
      royalties : Nat;
      name : Text;
      link : Text;
      image : Text;
      filePath : Text;
      owner : ExtCore.User;
      attributes : [KVPair];
      metadata : ?Blob;
  };

  public type MintRequests = {
      nftType : Text;
      fileType : Text;
      artistName : Text;
      introduction : Text;
      royalties : Nat;
      name : Text;
      link : Text;
      image : Text;
      filePath : Text;
      owner : ExtCore.User;
      attributes : [KVPair];
      metadata : ?Blob;
      count : Nat;
  };

  public type ApproveAllRequest = {
      spender : ExtCore.User;
      approved : Bool;
  };

  public type TransferRecord = {
    hash : Text;
    time : Int;
    txType : ExtTransactions.TransType;
    price : ExtCore.Balance;
    from : ExtCore.AccountIdentifier;//
    caller : ExtCore.AccountIdentifier;
    to : ExtCore.AccountIdentifier;
    tokenId : ExtCore.TokenIndex;
    tokenName : Text;
    amount : ExtCore.Balance;
    remark : Remark;
    memo : ?ExtCore.Memo;
  };


  public type TokenMetadata = {
      tokenId : ExtCore.TokenIndex;
      cId : Text;
      nftType : Text;
      fileType : Text;
      artistName : Text;
      introduction : Text;
      royalties : Nat;
      name : Text;
      link : Text;
      filePath : Text;
      minter : ExtCore.AccountIdentifier;
      mintTime : Int;
      owner : ExtCore.AccountIdentifier;
      attributes : [KVPair];
      metadata : ?Blob;
  };
  

  public type AllowanceRequest = {
    owner : ExtCore.User;
    spender : Principal;
    token : ExtCore.TokenIdentifier;
  };

  public type ApproveRequest = {
    subaccount : ?ExtCore.SubAccount;
    spender : Principal;
    allowance : ExtCore.Balance;
    token : ExtCore.TokenIdentifier;
  };

  public type Service = actor {
    mint : shared (request : MintRequest) -> async Result.Result<ExtCore.TokenIdentifier, Text>;      
    mintBatch : shared (request : MintRequests) -> async Result.Result<ExtCore.TokenIdentifier, Text>;
    approveForAll : shared (request : ApproveAllRequest) -> async Result.Result<Bool, Text>;
    
    approve: shared (request : ApproveRequest) -> async ();
    allowance: shared query (request : AllowanceRequest) -> async Result.Result<ExtCore.Balance, ExtCore.CommonError>;

    removeApproval : shared (request: ApproveRequest) -> async Result.Result<Bool, Text>;
    removeAllApproval : shared (request: ApproveAllRequest) -> async Result.Result<Bool, Text>;
    spenderRemoveApproval : shared (request: ExtCore.TokenIdentifier) -> async Result.Result<Bool, Text>;

    findTokenList : query (owner : ExtCore.User,offset: Nat, limit: Nat) -> async Result.Result<ExtCommon.Page<TokenMetadata>, Text>;
    findTokenMarket : query (seriesType : [Text],offset: Nat, limit: Nat) -> async Result.Result<ExtCommon.Page<TokenMetadata>, Text>;
  };
};
