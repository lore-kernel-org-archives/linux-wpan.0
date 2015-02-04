Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from spam1.webland.se ([91.207.112.90]:19512 "EHLO spam1.webland.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161337AbbBDUk2 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 4 Feb 2015 15:40:28 -0500
Message-ID: <54D28237.9060009@alten.se>
Date: Wed, 4 Feb 2015 21:33:59 +0100
From: Arvid Brodin <arvid.brodin@alten.se>
MIME-Version: 1.0
Subject: Re: [PATCH net 0/2] netns: audit netdevice creation with IFLA_NET_NS_[PID|FD]
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com> <54CBE2EF.7050003@alten.se> <54CF9EA8.4080207@6wind.com>
In-Reply-To: <54CF9EA8.4080207@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: nicolas.dichtel@6wind.com, netdev@vger.kernel.org
Cc: davem@davemloft.net, dmitry.tarnyagin@lockless.no, alex.aring@gmail.com, linux-wpan@vger.kernel.org

On 2015-02-02 16:58, Nicolas Dichtel wrote:
> Le 30/01/2015 21:00, Arvid Brodin a écrit :
>> On 2015-01-26 22:28, Nicolas Dichtel wrote:
>> *snip*
>>> - HSR subsystem uses src_net to parse IFLA_HSR_SLAVE[1|2], but the netdevice has
>>>    the flag NETIF_F_NETNS_LOCAL, so the question is: does this netdevice really
>>>    supports x-netns? If not, the newlink handler should use the dest_net instead
>>>    of src_net, I can provide the patch.
>> *snip*
>>
>> As the author of the HSR driver, I'd like to answer this question, but unfortunately
>> I don't know what x-netns is. Neither Google nor Documentation/ has been particularly
>> helpful.
>>
>> Care to elaborate? (Maybe this is a moot point now that the patch has been accepted,
>> but I'd still like to understand, if you have the time to explain.)
> Basically, network namespaces (netns) allow you to run several independant
> instances of the linux networking stack.
> Network interfaces are bound to one netns. By default, only one netns exists
> (named init_net) when you boot your kernel.
> For logical interfaces, they are usually bound to a link layer. For example, if
> I understand well, hsr network interfaces receive and send their packets from
> two physical interfaces (IFLA_HSR_SLAVE[1|2]).
> Now imagine that these slaves are in a netns foo and the logical hsr interfaces
> in netns bar. You have a x-netns interface, the link layer part of the interface
> is not in the same netns than the upper part. A user will see the hsr interface
> in netns bar, but this interface will send a receive packet in netns foo.

Ok, so x-netns simply means cross-netns?

> Usually, to configure an interface like this, you create it in netns foo and you
> move it later to netns bar (ip link set hsr1 netns bar). The flag
> NETIF_F_NETNS_LOCAL forbids this operation, you cannot move it to another netns.
> But you still can create a x-netns interface:
> ip netns add foo
> ip link add hsr1 netns foo type hsr slave1 eth0 slave2 eth1
> ip netns exec foo ip link ls hsr1
> 
> => eth0 and eth1 are took from the current netns (because in the code, src_net
> is the current netns) but hsr1 is built in netns foo.
> 
> Now, the question is: does HSR really work across netns? Why is the flag
> NETIF_F_NETNS_LOCAL set?
> dev_forward_skb() may be used to forward an skbuff to another netns.

Here is the code snippet that sets NETIF_F_NETNS_LOCAL:
	/* Not sure about this. Taken from bridge code. netdev_features.h says
	 * it means "Does not change network namespaces".
	 */
	dev->features |= NETIF_F_NETNS_LOCAL;

HSR is a bit like a bridge since it forwards packets between interfaces on the 
same Ethernet network, and the bridge code sets NETIF_F_NETNS_LOCAL. And that's 
really all the reason for the inclusion of the flag - i.e. it should be removed
if it doesn't make sense.

So, does it make sense? I'm not sure exactly, but I don't think it makes sense
to have slaves that are in different namespaces - they are supposed to be part 
of the same ethernet network after all. But maybe having the HSR interface in a 
different namespace than the two slaves could make sense - this way you could 
force an application to only communicate using the HSR protocol, and not use any 
of the slave interfaces directly.

If you agree with the above, then I guess that means NETIF_F_NETNS_LOCAL should 
not be set?


> Note, that I got a panic when playing with hsr:
> ip link add hsr1 type hsr slave1 eth1 slave2 eth0
> ip link del hsr1
> => panic
> 
> I dig a bit:
> 1/ hsr_netdev_notify() supposes that the port will always be available when the
> notification is for an hsr interface. It's wrong. For example,
> netdev_wait_allrefs() may resend NETDEV_UNREGISTER.
> 2/ with a patch that ignores the notification when the port is NULL, I got a
> refcnt problem:
> [  327.372099] unregister_netdevice: waiting for hsr1 to become free. Usage count = -1

Thanks for the bug report! I'll take a look at it ASAP.


-- 
Arvid Brodin | Consultant (Linux)
ALTEN | Knarrarnäsgatan 7 | SE-164 40 Kista | Sweden
arvid.brodin@alten.se | www.alten.se/en/

