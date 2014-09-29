Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:65405 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbaI2Nvy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 09:51:54 -0400
Message-ID: <542963F7.4030903@xsilon.com>
Date: Mon, 29 Sep 2014 14:51:51 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <20140927014243.GA26666@omega> <54293279.5090103@xsilon.com> <54293B6C.7040800@gmail.com> <54293DD4.1090907@xsilon.com> <5429441C.5000302@gmail.com> <5429466F.4080506@gmail.com> <54295556.3030800@xsilon.com> <20140929131200.GA14608@omega> <20140929133048.GB14608@omega> <54295FA9.8030506@xsilon.com> <20140929133841.GA15176@omega>
In-Reply-To: <20140929133841.GA15176@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Sorry for the confusion. My problem is I am receiving all packets. 
PACKET_OTHERHOST does not seem to be dropped. A suggestion from Varka 
was to disable redirects however it now seems that this is not possible 
on a ipv6 interface.

I can fix the problem by dropping PACKET_OTHERHOST in 
mac802154_subif_frame.

On 29/09/14 14:38, Alexander Aring wrote:
> Simon,
>
> On Mon, Sep 29, 2014 at 02:33:29PM +0100, Simon Vincent wrote:
>> Yes. It seems to be part of the ipv6 std that you can't disable redirects.
>> http://www.gossamer-threads.com/lists/nsp/ipv6/20760
> I don't understand now. Is your issue that you want to disable redirects
> but you can't. Or something is not working because PACKET_OTHERHOST has
> a wrong handling.
>
> Your first mail shows that you have issues with PACKET_OTHERHOST and
> these packets are not dropped.
>
> Now we talk about disabling ICMPv6 redirects. All PACKET_OTHERHOST
> sk_buff's should be dropped by IPv6 layer.
>
> - Alex

