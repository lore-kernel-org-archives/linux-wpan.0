Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:46258 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbaIRQFF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 12:05:05 -0400
Received: by mail-we0-f174.google.com with SMTP id x48so1183700wes.33
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 09:05:03 -0700 (PDT)
Date: Thu, 18 Sep 2014 18:05:01 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Promiscuous patches
Message-ID: <20140918160458.GB9262@omega>
References: <541AAE3A.80306@xsilon.com>
 <20140918104322.GA5217@omega>
 <541AC962.7090301@xsilon.com>
 <20140918122140.GA6777@omega>
 <20140918123024.GB6777@omega>
 <20140918124430.GA8268@omega>
 <541ADD3B.8090706@xsilon.com>
 <20140918133424.GA8458@omega>
 <20140918134210.GB8458@omega>
 <541AEE07.8030804@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541AEE07.8030804@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi Martin,

On Thu, Sep 18, 2014 at 03:36:55PM +0100, Martin Townsend wrote:
> 
> On 18/09/14 14:42, Alexander Aring wrote:
> > On Thu, Sep 18, 2014 at 03:34:24PM +0200, Alexander Aring wrote:
> > ...
> >>> I want to be able from COORD or NODE mode to put the device in promiscuous mode so packets can be received by wireshark.  For example if we are seeing a problem on a device, I want to be able to ssh into this node via Ethernet (or maybe connect via the serial console) and run tcpdump -U -i wpan0 to help debugging by seeing what packets are being sent/received.  As it's going to stdout it will be sent over ssh and I can then do some pipe redirection to pipe it into Wireshark running on a different machine.
> >>>
> >>> From my understanding this is not MONITOR mode and I don't won't to put the device into MONITOR mode as this could effect it's functionality.
> >>> I'm currently looking at how tcpdump does this and it looks like it uses a raw socket using PF_PACKET.  I think it then sets the IFF_PROMISC flag on this socket to put the device into promiscuous mode.  As I'm in COORD or NODE mode this will arrive at the ndo_change_rx_flags for the net device ops defined in wpan.c not monitor.c in my linux tree.
> > Has nothing to do with raw sockets, I think.
> I'm just going on what I'm seeing in libpcap, I think tshark and tcpdump both use this library.  If you have a debug environment setup, set a breakpoint on activate_new or look through pcap-linux.c, one of the first things it does is:
>     sock_fd = is_any_device ?
>         socket(PF_PACKET, SOCK_DGRAM, htons(ETH_P_ALL)) :
>         socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
> 
> is_any_device should be set to false as we are capturing a specific device so we should be creating a raw socket.  Then later on
>     if (!is_any_device && handle->opt.promisc) {
>         memset(&mr, 0, sizeof(mr));
>         mr.mr_ifindex = handlep->ifindex;
>         mr.mr_type    = PACKET_MR_PROMISC;
>         if (setsockopt(sock_fd, SOL_PACKET, PACKET_ADD_MEMBERSHIP,
>             &mr, sizeof(mr)) == -1) {
>             snprintf(handle->errbuf, PCAP_ERRBUF_SIZE,
>                 "setsockopt: %s", pcap_strerror(errno));
>             close(sock_fd);
>             return PCAP_ERROR;
>         }
>     }
> Then I think this ends up in the kernel at packet_dev_mc
> http://lxr.free-electrons.com/source/net/packet/af_packet.c#L3060
> which calls dev_set_promiscuity.
> 

yes, there existing any magic for capturing all interface incomming and
outcomming data. But I don't know now how this is related currently.

You exacly want the incomming/outcomming data of an interface and that's
what the default behaviour is. There existing also some netdev flag
which activate this the "IFF_PROMISC". But then we don't need any
handling to turn the device driver into any special mode?

We already support the promiscuous mode. I mean the normal capturing of
interface data and this is the default behaviour, we don't need any
extra implementation to make something when rx flag IFF_PROMISC is set.

Is there something missing now, which we should support when activate
wireshark & co on a wpan interface?

- Alex
