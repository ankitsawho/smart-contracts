//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Dwip{
    string name = "Dwip";
    uint public index = 0;
    uint public post_count = 0;
    mapping(uint => Post) public posts;

    struct Post{
        uint id;
        string content;
        uint likes;
        address payable author;
    }

    event PostCreate(
        uint id,
        string content,
        uint likes,
        address payable author
    );

    event PostLike(
        uint id,
        string content,
        uint likes,
        address payable author
    );

    function postContent(string memory _content) public {
        require(bytes(_content).length > 0);
        require(msg.sender != address(0));
        post_count = post_count + 1;
        index = index + 1;
        posts[post_count] = Post(post_count, _content, 0, payable(msg.sender));
        emit PostCreate(post_count, _content, 0, payable(msg.sender));
    }

    function postLike(uint _id) public {
        require(_id > 0 && _id <= post_count);
        Post memory post = posts[_id];
        post.likes = post.likes + 1;
        posts[_id] = post;
        emit PostLike(_id, post.content, post.likes, post.author);
    }

    function deletePost(uint _id) public{
        require(_id > 0 && _id <= post_count);
        delete posts[_id];
        post_count = post_count - 1;
    }
}
