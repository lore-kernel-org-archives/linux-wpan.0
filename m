Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61880 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbaI2OMZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 10:12:25 -0400
Message-ID: <542968C5.7000505@xsilon.com>
Date: Mon, 29 Sep 2014 15:12:21 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <54293B6C.7040800@gmail.com> <54293DD4.1090907@xsilon.com> <5429441C.5000302@gmail.com> <5429466F.4080506@gmail.com> <54295556.3030800@xsilon.com> <20140929131200.GA14608@omega> <20140929133048.GB14608@omega> <54295FA9.8030506@xsilon.com> <20140929133841.GA15176@omega> <542963F7.4030903@xsilon.com> <20140929135759.GA15411@omega>
In-Reply-To: <20140929135759.GA15411@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org


On 29/09/14 14:58, Alexander Aring wrote:
> On Mon, Sep 29, 2014 at 02:51:51PM +0100, Simon Vincent wrote:
>> Sorry for the confusion. My problem is I am receiving all packets.
>> PACKET_OTHERHOST does not seem to be dropped. A suggestion from Varka was to
>> disable redirects however it now seems that this is not possible on a ipv6
>> interface.
>>
>> I can fix the problem by dropping PACKET_OTHERHOST in mac802154_subif_frame.
> The first what IPv6 does is [0].
>
> See my previous mail. Also that we should handle on 6LoWPAN packet
> handler function for receiving "lowpan_rcv" we should do the same,
> otherwise we parsing PACKET_OTHERHOST sk_buff's and drop these directly
> in IPv6 layer, which makes no sense.
>
> But what I see is that the current behaviour should also work.
> Instrument the IPv6 delivery function and be sure that the information
> about PACKET_OTHERHOST was not dropped.
I do not catch any PACKET_OTHERHOST packets in the ip6_input.c ipv6_rcv 
function.
I don't think the packets get this far. Also in the ieee802154_rcv 
function they are dropped. I will add some more debug to find where the 
redirects come from.
