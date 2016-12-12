Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44757 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752956AbcLLNzt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Dec 2016 08:55:49 -0500
Subject: Re: Project Todo list updated
References: <6e9208bd-cd35-bf0b-e55a-b06b0202c79a@osg.samsung.com>
 <d54f371e-ba02-71dc-6208-228560a51d00@pengutronix.de>
 <c8b12a51-c756-6160-708f-942578403c39@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <258cf2b7-93b5-2814-b2cd-7d27a709ba0e@pengutronix.de>
Date: Mon, 12 Dec 2016 14:55:46 +0100
MIME-Version: 1.0
In-Reply-To: <c8b12a51-c756-6160-708f-942578403c39@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


Hi,

On 11/30/2016 11:23 AM, Stefan Schmidt wrote:
> Hello.
> 
> On 30/11/16 10:19, Alexander Aring wrote:
>>
>>
>> During my thesis I think I found some stuff which I want to bring
>> mainline to the subsystems 802.15.4/6lowpan can deal with some parts.
>>
>> Currently I have very hacked solutions for it, but I think I know what I
>> need to make it mainline acceptable. This is:
>>
>> 1. 6lowpan netlink interface.
> 
> What do you mean here? A configuration interface for 6lowpan or something else?
> 

I thought about to handle at first stateful contexts over netdevice. How
to solve it currently I don't know.

There are two possible solutions:

 1. Own 6LoWPAN netlink
 2. RTNL netlink

The second one I already use to dump short address over ip -6 neigh... I
have patches for that somewhere.

So the stateful compression is really something which doesn't has other
subsystems... According (irc) myeisha suggest to add a nested netlink
attribute to ROUTE RTNL commands, this would work similar like I already
do with ip -6 neigh.

If we do it in RTNL then we can add support for that in iproute2 and
don't need to care about own 6lowpan userspace tool.

Or exists there more what I have not in my mind yet to creating an own
6lowpan netlink userspace tool.

>>
>> 2. L2_PKTINFO for SOCK_RAW/SOCK_DGRAM IPv6 sockets
> 
> Added to the todo list and marked it as being worked on by you.
> 

ok.

>> 3. iptable 6lowpan stuff/which can also deal with some L2 infos. Really
>>    weird mixing L3 and L2 info in rules. :-/ Currently it's hard coded
>>    at my side.
> 
> Added to the todo list and marked it as being worked on by you.
> 

ok. But don't know how upstream code would look like. :-/

>> 4. node info dump
> 
> Marked as being worked on by you.
> 

ok.

I also teached the fakelb driver "edges" you can create every PHY
connection "which phy talks to other phy/creating asymmetric
connections/etc". I think that's a really big improve to testing routing
stuff for unstrung, etc. Michael Richardson is already interested in.

- Alex
