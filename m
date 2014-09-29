Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:45576 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbaI2MOt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 08:14:49 -0400
Received: by mail-we0-f170.google.com with SMTP id q58so3379493wes.1
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 05:14:48 -0700 (PDT)
Date: Mon, 29 Sep 2014 14:14:45 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140929121444.GB13564@omega>
References: <20140927014243.GA26666@omega>
 <54293279.5090103@xsilon.com>
 <54293B6C.7040800@gmail.com>
 <54293DD4.1090907@xsilon.com>
 <5429441C.5000302@gmail.com>
 <5429466F.4080506@gmail.com>
 <20140929115351.GA13173@omega>
 <20140929115700.GB13173@omega>
 <542949AE.30701@gmail.com>
 <54294BE7.7040501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54294BE7.7040501@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org

On Mon, Sep 29, 2014 at 05:39:11PM +0530, Varka Bhadram wrote:
> On 09/29/2014 05:29 PM, Varka Bhadram wrote:
> >On 09/29/2014 05:27 PM, Alexander Aring wrote:
> >>On Mon, Sep 29, 2014 at 01:53:51PM +0200, Alexander Aring wrote:
> >>>On Mon, Sep 29, 2014 at 05:15:51PM +0530, Varka Bhadram wrote:
> >>>>On 09/29/2014 05:05 PM, Varka Bhadram wrote:
> >>>>>On 09/29/2014 04:39 PM, Simon Vincent wrote:
> >>>>>>On 29/09/14 11:58, Varka Bhadram wrote:
> >>>>>>>Simon,
> >>>>>>>
> >>>>>>>On 09/29/2014 03:50 PM, Simon Vincent wrote:
> >>>>>>>>Currently there does not seem to be any filtering in the mac layer
> >>>>>>>>anyway. In wpan.c mac802154_subif_frame we check the pan id and dest
> >>>>>>>>address but we don't discard any packets. Should we be discarding
> >>>>>>>>packets at this point? For example packets of type PACKET_OTHERHOST.
> >>>>>>>>
> >>>>>>>>If I discard all PACKET_OTHERHOST in mac802154_subif_frame it solves
> >>>>>>>>my problem. I just don't know if this will effect anything else.
> >>>>>>>>
> >>>>>>>I think we are not supposed to discard the packets like this. This will
> >>>>>>>create the problems if routing enabled on the node.
> >>>>>>>
> >>>>>>>This not problem with the IEEE-802.15.4 driver or MAC implementation.
> >>>>>>>
> >>>>>>>These issues related to IPv6/ICMPv6 (ECHO request and ECHO reply).
> >>>>>>>Here RFC2461/RFC4861 will
> >>>>>>>come into picture. see:http://www.tahi.org/logo/phase2-core/result/Self_Test_4-0-3/freebsd71.router/nd.p2/
> >>>>>>>
> >>>>>>>Can you explain the setup..? What h/w you are using. How the network
> >>>>>>>connected..?
> >>>>>>>
> >>>>>>I am running three nodes all directly connected to each other via
> >>>>>>powerline networking running 802.15.4.
> >>>>>>Therefore all nodes can see all the traffic. The nodes are setup with
> >>>>>>ipv6 forwarding enabled.
> >>>>>>If I ping node A from node B node C sends ICMP redirects.
> >>>>>Please add:
> >>>>>
> >>>>>net.ipv6.conf.all.accept_redirects = 1
> >>>>>net.ipv6.conf.all.send_redirects = 1
> >>>>>
> >>>>>to your//etc/sysctl.conf/  file.. It will disable redirect..
> >>>>>
> >>>>>Try this . I hope it will work.
> >>>>Sorry for the wrong info...
> >>>>
> >>>>Set up accept_redirects/send_redirects to boolean value '0'
> >>>>
> >>>>echo 0 > /proc/sys/net/ipv6/conf/all/accept_redirects
> >>>>
> >>>don't know but I think this is only if we send or accept the route
> >>>ICMPv6 messages. You only configure some filtering if you get these
> >>>ICMPv6 messages or not, or if you send these ICMPv6 messages.
> >>>
> >>ah yes and this also make handling of these ICMPv6 messages or not.
> >>
> >>But Simon, did some dropping of skb's when these are PACKET_OTHERHOST,
> >>and then it works for him. So this should some other issues, because
> >>IPv6 should drop all sk_buff's which are PACKET_OTHERHOST.
> >>
> >>Which should be the same like dropping PACKET_OTHERHOST in mac802154.
> >>
> >>- Alex
> >Please see:*http://lxr.free-electrons.com/source/net/ieee802154/af_ieee802154.c?v=2.6.34#L319*
> >If packet type is PACKET_OTHERHOST its dropping, isn't it..?
> 
> The packet type assign value is happening here [1].
> 
> [1]:  http://lxr.free-electrons.com/source/net/mac802154/wpan.c#L420  <http://lxr.free-electrons.com/source/net/mac802154/wpan.c#L420>

yep, that's what Simon mentioned the function "mac802154_subif_frame".

- Alex
