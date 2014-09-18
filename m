Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41465 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927AbaIRNmP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 09:42:15 -0400
Received: by mail-wi0-f178.google.com with SMTP id ho1so1225090wib.5
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 06:42:14 -0700 (PDT)
Date: Thu, 18 Sep 2014 15:42:11 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Promiscuous patches
Message-ID: <20140918134210.GB8458@omega>
References: <541A9E65.3090300@xsilon.com>
 <20140918094123.GA4350@omega>
 <541AAE3A.80306@xsilon.com>
 <20140918104322.GA5217@omega>
 <541AC962.7090301@xsilon.com>
 <20140918122140.GA6777@omega>
 <20140918123024.GB6777@omega>
 <20140918124430.GA8268@omega>
 <541ADD3B.8090706@xsilon.com>
 <20140918133424.GA8458@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140918133424.GA8458@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Sep 18, 2014 at 03:34:24PM +0200, Alexander Aring wrote:
...
> > I want to be able from COORD or NODE mode to put the device in promiscuous mode so packets can be received by wireshark.  For example if we are seeing a problem on a device, I want to be able to ssh into this node via Ethernet (or maybe connect via the serial console) and run tcpdump -U -i wpan0 to help debugging by seeing what packets are being sent/received.  As it's going to stdout it will be sent over ssh and I can then do some pipe redirection to pipe it into Wireshark running on a different machine.
> > 
> > From my understanding this is not MONITOR mode and I don't won't to put the device into MONITOR mode as this could effect it's functionality.
> > I'm currently looking at how tcpdump does this and it looks like it uses a raw socket using PF_PACKET.  I think it then sets the IFF_PROMISC flag on this socket to put the device into promiscuous mode.  As I'm in COORD or NODE mode this will arrive at the ndo_change_rx_flags for the net device ops defined in wpan.c not monitor.c in my linux tree.

Has nothing to do with raw sockets, I think.

> > 
> > I notice in your linux-wpan-next alex/wip branch there is no wpan.c or monitor.c, and I can't see how I can be a COORD or NODE and capture packets.
> > 

ahh these types are only for the rework. Mainline is NODE = WPAN and
COORD doesn't exist.

COORD is the new type for handling some pan coordinator functionality
inside of kernelspace. Forget this.

> 
> Then you simple need to rum wireshark/tcpdump etc.
> 
> I use:
> 
> "ssh root@$IP 'tshark -i wpan0 -w -' | wireshark -k -i -"
> 
> replace $IP with $IP of ethernet 802.15.4 node. Then you only see frames
> with filtering and belongs to you and whatever any interface capture then.
> Require ssh on both, tshark on target and wireshark on host.
> 
> 
> What we talking about is promiscousmode setting according 802.15.4-2011.
> With that you don't need to set any register setting, just start
s/With/In this case/
> capturing the interface. Also no special handling for IFF_PROMISC is
> needed.

I hope we comming near to any solution what we both want. :-/

- Alex
