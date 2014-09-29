Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:52367 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbaI2Nyj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 09:54:39 -0400
Received: by mail-pa0-f41.google.com with SMTP id eu11so2173838pac.0
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 06:54:38 -0700 (PDT)
Message-ID: <54296499.9080406@gmail.com>
Date: Mon, 29 Sep 2014 19:24:33 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <20140927014243.GA26666@omega> <54293279.5090103@xsilon.com> <54293B6C.7040800@gmail.com> <54293DD4.1090907@xsilon.com> <5429441C.5000302@gmail.com> <5429466F.4080506@gmail.com> <54295556.3030800@xsilon.com> <20140929131200.GA14608@omega> <20140929133048.GB14608@omega> <54295FA9.8030506@xsilon.com> <20140929133841.GA15176@omega> <542963F7.4030903@xsilon.com>
In-Reply-To: <542963F7.4030903@xsilon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org


On Monday 29 September 2014 07:21 PM, Simon Vincent wrote:
> Sorry for the confusion. My problem is I am receiving all packets. 
> PACKET_OTHERHOST does not seem to be dropped. A suggestion from Varka 
> was to disable redirects however it now seems that this is not 
> possible on a ipv6 interface.
>
Have you seen this [1].

[1] :http://linuxpoison.blogspot.in/2010/01/how-to-disable-icmp-redirects-in-linux.html

> I can fix the problem by dropping PACKET_OTHERHOST in 
> mac802154_subif_frame.

-- 
-Varka Bhadram

