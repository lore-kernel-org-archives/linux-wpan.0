Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:57825 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbbBBP6f (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Feb 2015 10:58:35 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so39558914wgg.4
        for <linux-wpan@vger.kernel.org>; Mon, 02 Feb 2015 07:58:34 -0800 (PST)
Message-ID: <54CF9EA8.4080207@6wind.com>
Date: Mon, 02 Feb 2015 16:58:32 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reply-To: nicolas.dichtel@6wind.com
MIME-Version: 1.0
Subject: Re: [PATCH net 0/2] netns: audit netdevice creation with IFLA_NET_NS_[PID|FD]
References: <1422307694-10079-1-git-send-email-nicolas.dichtel@6wind.com> <54CBE2EF.7050003@alten.se>
In-Reply-To: <54CBE2EF.7050003@alten.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Arvid Brodin <arvid.brodin@alten.se>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dmitry.tarnyagin@lockless.no, alex.aring@gmail.com, linux-wpan@vger.kernel.org

Le 30/01/2015 21:00, Arvid Brodin a écrit :
> On 2015-01-26 22:28, Nicolas Dichtel wrote:
> *snip*
>> - HSR subsystem uses src_net to parse IFLA_HSR_SLAVE[1|2], but the netdevice has
>>    the flag NETIF_F_NETNS_LOCAL, so the question is: does this netdevice really
>>    supports x-netns? If not, the newlink handler should use the dest_net instead
>>    of src_net, I can provide the patch.
> *snip*
>
> As the author of the HSR driver, I'd like to answer this question, but unfortunately
> I don't know what x-netns is. Neither Google nor Documentation/ has been particularly
> helpful.
>
> Care to elaborate? (Maybe this is a moot point now that the patch has been accepted,
> but I'd still like to understand, if you have the time to explain.)
Basically, network namespaces (netns) allow you to run several independant
instances of the linux networking stack.
Network interfaces are bound to one netns. By default, only one netns exists
(named init_net) when you boot your kernel.
For logical interfaces, they are usually bound to a link layer. For example, if
I understand well, hsr network interfaces receive and send their packets from
two physical interfaces (IFLA_HSR_SLAVE[1|2]).
Now imagine that these slaves are in a netns foo and the logical hsr interfaces
in netns bar. You have a x-netns interface, the link layer part of the interface
is not in the same netns than the upper part. A user will see the hsr interface
in netns bar, but this interface will send a receive packet in netns foo.
Usually, to configure an interface like this, you create it in netns foo and you
move it later to netns bar (ip link set hsr1 netns bar). The flag
NETIF_F_NETNS_LOCAL forbids this operation, you cannot move it to another netns.
But you still can create a x-netns interface:
ip netns add foo
ip link add hsr1 netns foo type hsr slave1 eth0 slave2 eth1
ip netns exec foo ip link ls hsr1

=> eth0 and eth1 are took from the current netns (because in the code, src_net
is the current netns) but hsr1 is built in netns foo.

Now, the question is: does HSR really work across netns? Why is the flag
NETIF_F_NETNS_LOCAL set?
dev_forward_skb() may be used to forward an skbuff to another netns.

Note, that I got a panic when playing with hsr:
ip link add hsr1 type hsr slave1 eth1 slave2 eth0
ip link del hsr1
=> panic

I dig a bit:
1/ hsr_netdev_notify() supposes that the port will always be available when the
notification is for an hsr interface. It's wrong. For example,
netdev_wait_allrefs() may resend NETDEV_UNREGISTER.
2/ with a patch that ignores the notification when the port is NULL, I got a
refcnt problem:
[  327.372099] unregister_netdevice: waiting for hsr1 to become free. Usage 
count = -1

Regards,
Nicolas
