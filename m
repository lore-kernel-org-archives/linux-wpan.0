Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw02.it.ntnu.no ([129.241.56.175]:34248 "EHLO
        mailgw02.it.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbdKKWyR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Nov 2017 17:54:17 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Bridging a lowpan interface
From: David Palma <david.palma@ntnu.no>
In-Reply-To: <22033.1510426407@obiwan.sandelman.ca>
Date: Sat, 11 Nov 2017 23:59:12 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <7828B4AD-AE60-4783-829D-899F028CB3A6@ntnu.no>
References: <1BB434E6-8E27-4282-84FE-4CC88C48ED68@ntnu.no>
 <730.1510335972@obiwan.sandelman.ca>
 <D59C859A-19A4-4898-A7E1-19C09BEBEA4E@ntnu.no>
 <22033.1510426407@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>


> On 11 Nov 2017, at 19:53, Michael Richardson <mcr@sandelman.ca> wrote:
> 
> 
> David Palma <david.palma@ntnu.no> wrote:
>> I'm all for routing and starting with RPL is fine. However, the idea
>> was also to enable traffic differentiation based on flows (the SDN
>> part), without breaking them, and not only based on IP
>> addresses. That's why I mentioned that I used routing and ip6tables.
> 
> I don't understand what the problem is.
> What would you do with bridged interfaces in an SDN?

For example, if you use Open vSwitch for the SDN part, you add an interface to a bridge and manage flows from there.

> What kind of breaking are you speaking of?

By breaking I mean, for example:
- establish a CoAP transaction with DTLS through one interface/network (e.g. .11, fd03::120)
- redirect the traffic to another interface/network (e.g. 15.4, fe80::ff:fe00:beef)
- a new transaction will be created on the CoAP server, it will expect a DTLS handshake, it will timeout because the client is not expecting a new transaction.

I guess this could happen in other scenarios too, but I could be wrong.

My approach to this is re-writing the sources and destinations at the edges, per flow (using Ip6tables for the time being).

What I thought was that if the 8/2 byte addresses were converted to 6 byte addresses one could just use Open vSwitch/bridges/etc.

--
David

http://dpalma.eu

> 
> --
> ]               Never tell me the odds!                 | ipv6 mesh networks [
> ]   Michael Richardson, Sandelman Software Works        | network architect  [
> ]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [
> 

