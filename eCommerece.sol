// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;
contract eCommerece{
    struct product{
        string name;
        string description;
        address payable seller;
        uint productId;
        uint price;
        address payable buyer;
        bool delivery;
    }
    uint counter=1;
     product[] public products;
     event registered(string name, uint productId,address seller);
     event bought(uint productId,address seller);
     event delivered(uint productId);
     function registerProduct(string memory _name,string memory _description,uint _price) public  {
        require(_price>0,"price must begreater than 0");
        product memory temproduct; 
        temproduct.name=_name;
        temproduct.description=_description;
        temproduct.price=_price; 
        temproduct.seller=payable(msg.sender);
        temproduct.productId=counter;
        products.push(temproduct);
        counter ++;
        emit registered(_name,temproduct.productId,msg.sender);
     }
     function buyProduct(uint _productId) public payable {
        require(products[_productId-1].price==msg.value,"pay the exact price");
        require(products[_productId-1].seller!=msg.sender,"seller should not be buyer of the product");
        products[_productId-1].buyer=payable  (msg.sender);
        emit bought(_productId,msg.sender);
     }
     function delivery(uint _productId) public  {
        require(products[_productId-1].buyer==msg.sender,"only buyer can check this");
         products[_productId-1].delivery=true;
         products[_productId-1].seller.transfer(products[_productId-1].price);
          emit delivered(_productId);
         
     }
}
