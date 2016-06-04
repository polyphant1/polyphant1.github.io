---
layout: post
title: "Getting started with Ethereum"
comments: true
date: "Saturday, June 04, 2016"
tags:
- Technology
excerpt: A guide to getting up and running with the latest hype cryptocurrency
---

[Ethereum](https://www.ethereum.org) is the new kid on the cryptocurrency block, and I recently got involved by buying up some Ether. I've since made ~£15 on my modest investment in about a fortnight, and have consequently made detailed plans for what I will spend my inevitable millions on. But, given how volatile it is at the moment, I am fully prepared to lose the same amount again by next week. If you fancy risking some of your hard cash doing the same then here are the steps I took to get started.

![Ethereum](/images/eth_head.png)

> *It goes without saying that this post does not represent investment advice in any form. I bought my Ether on the understanding that I could lose the whole lot, and you should too.*


## Set up an Ethereum Wallet

Before you can buy any Ether you need to create a virtual wallet to store it in. To get your hands on one, you first need to install the appropriate Ethereum Wallet client based on your platform from [here](https://github.com/ethereum/mist/releases). For the rest of this guide I'll assume you're using Linux, but the set up shouldn't be too different if you're on Mac or Windows.

You wallet is not exactly like a physical wallet. For a start, it doesn't actually contain Ether. If you copy and paste it, you don't end up with double the amount of coins (unfortunately). It is, essentially, a couple of keys that prove to the wider blockchain network that you are who you say you are. The whole of the blockchain is public, so these keys are necessary to identify who owns what accounts.

It works using public/private key encryption. This is a simple but powerful concept. When you create a wallet, it creates a pair of keys, a public and a private one. The public key is the one you give to people so that they can pay you Ether. It provides a unique address through which people can identify your account, but they can't gain access to it using this key. Your private key, on the other hand, provides full access to your wallet. It's password encrypted, so that even if someone gets their hands on the private key they still have to crack your password to get access to your Ether.

Despite this, it is still recommended that you treat your private key as it was named. It is also essential that you don't lose it, otherwise you will lose access to your Ether! We will cover backing up your wallet later.

You can download 3rd party apps, for desktop and mobile, that provide wallet functionality, but take care: if your wallet is compromised you could lose all your Ether, so only use applications from trusted developers.

When you first launch the Ethereum wallet you'll notice that it launches in to the test environment. This is a cosy, safe environment within which you're at no risk of cocking anything up, so go ahead and familiarise yourself with the wallet. You can grab some free test Ether [here](https://test.ether.camp/), create some toy contracts, and generally explore the technology in a risk free environment.


## Install Geth and Download the Blockchain (Fast)

Once you're ready to move off the test network, click on *Develop/Network/Main Network* within the wallet application, then close it. To connect to the Main network you first need to download the full blockchain. This can be around 6Gb in size, so make sure you have enough space on your machine for it. The wallet application will start downloading the blockchain when next launched, but can take a heck of a long time, tens of hours if you're unlucky. Fortunately, there's a quicker way of getting hold of it, using the ethereum terminal interface, *geth*.

Go grab your required version of geth [here](https://www.ethereum.org/cli), and install it. Once it's installed, first make sure that the Wallet application is closed. Then open the terminal and launch geth with the following flags:

{% highlight tcl %}
geth --fast --cache=1024 console
{% endhighlight %}

This will launch geth and start the blockchain download, but much faster than the wallet application. To check the progress of the download, run the following from the geth console:

{% highlight tcl %}
> eth.syncing
{% endhighlight %}

If this returns false, you're in sync, i.e. the blockchain is downloaded, and you can kill geth with `exit` and laucnh the wallet. If not, it should display something similar to below:

{% highlight text %}
{
  currentBlock: 766451,
  highestBlock: 773332,
  startingBlock: 766451
}
{% endhighlight %}

Here, `currentBlock` is the head of our node, and `highestBlock` is the highest reported peer head. In other words, `currentBlock - highestBlock` is the amount of data that must be downloaded to update our node. So, whilst geth is running, you can check how fast it's downloading the blockchain by periodically checking the sync status.

Once the blockchain has downloaded, close geth and launch the wallet again. From here you will see an overview of your wallets and accounts. There should be a single account visible, called `MAIN ACCOUNT (ETHERBASE)`. This is the account where any mined Ether is stored - if this means nothing to you don't worry, you can safely ignore it. To create a new wallet, click the *Add Account* button, and enter a password. This password is just as important as your wallet keys, so make it something secure that you will never forget. There's no 'unlock account' functionality with Ethereum, so if you forget it you've lost everything.

You can check your password from the geth console:

{% highlight tcl %}
personal.unlockAccount(eth.accounts[i])
{% endhighlight %}

where `i` is the index of the account you wish to check. It will then prompt you for your password, and return `true` if entered correctly.

## Back up your Wallet

If I didn't labour the point enough before, let me reiterate it again - your wallet is **everything**. If you lose it... yep, you lose your Ether. Simple as that. So, it's worth backing it up, preferably in more than one place.

Depending on your platform, the relevant files you'll want to backup are in the following locations:

- Linux: ~/.ethereum/keystore
- Mac: /Library/Ethereum/keystore
- Windows: %APPDATA%/Ethereum

## Buy Ether

You're now ready to buy some real Ether! There are hundreds of vendors online, but many have limited payment options depending on where you live. In the UK, for example, it can be difficult to find vendors that accept UK payments. I used [CryptoMate](https://cryptomate.co.uk/buy-ethereum/), but I advise you shop around for the best deal.

I **strongly** advise that you spend time looking for a trustworthy vendor, preferably one that a friend can vouch for. Don't go sending pictures of your bank card to random people on messaging platforms, otherwise in all likelihood you will get screwed. You have been warned.

When you're ready, you'll need your wallet address, which you can access from the wallet application. Or, if you're really beginning to like geth, then launch it and check your wallet address from the console as so:

{% highlight tcl %}
eth.accounts
{% endhighlight %}

It usually takes a few hours for your Ether to come through, so don't panic if it's not immediately visible in your account. You can check your balance in the wallet app, or from the geth console:

{% highlight tcl %}
eth.getBalance(eth.accounts[i])
{% endhighlight %}

where `i` is the index of the account you wish to check.

## Go forth and prosper

Be sure to check out the [Ethereum Reddit](https://www.reddit.com/r/ethereum) page for the latest news, and consult the [stack exchange site](http://ethereum.stackexchange.com/) if you have questions or problems.

If you're feeling particularly generous (!) you can donate me some Ether at my address below:

`0xc33341e8044fd88aab7ead630dee83f1dc4e3ddf`

Thanks for reading!
