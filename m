Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:65050 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbaI2LJL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 07:09:11 -0400
Message-ID: <54293DD4.1090907@xsilon.com>
Date: Mon, 29 Sep 2014 12:09:08 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <54258332.2010004@xsilon.com> <20140926153521.GA7643@omega> <542593AC.4060901@xsilon.com> <20140927014243.GA26666@omega> <54293279.5090103@xsilon.com> <54293B6C.7040800@gmail.com>
In-Reply-To: <54293B6C.7040800@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org


On 29/09/14 11:58, Varka Bhadram wrote:
> Simon,
>
> On 09/29/2014 03:50 PM, Simon Vincent wrote:
>> Currently there does not seem to be any filtering in the mac layer 
>> anyway. In wpan.c mac802154_subif_frame we check the pan id and dest 
>> address but we don't discard any packets. Should we be discarding 
>> packets at this point? For example packets of type PACKET_OTHERHOST.
>>
>> If I discard all PACKET_OTHERHOST in mac802154_subif_frame it solves 
>> my problem. I just don't know if this will effect anything else.
>>
> I think we are not supposed to discard the packets like this. This will
> create the problems if routing enabled on the node.
>
> This not problem with the IEEE-802.15.4 driver or MAC implementation.
>
> These issues related to IPv6/ICMPv6 (ECHO request and ECHO reply). 
> Here RFC2461/RFC4861 will
> come into picture. 
> see:http://www.tahi.org/logo/phase2-core/result/Self_Test_4-0-3/freebsd71.router/nd.p2/
>
> Can you explain the setup..? What h/w you are using. How the network 
> connected..?
>
I am running three nodes all directly connected to each other via 
powerline networking running 802.15.4.
Therefore all nodes can see all the traffic. The nodes are setup with 
ipv6 forwarding enabled.
If I ping node A from node B node C sends ICMP redirects.
