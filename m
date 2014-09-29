Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:60572 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbaI2OMa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 10:12:30 -0400
Message-ID: <542968CA.6040809@xsilon.com>
Date: Mon, 29 Sep 2014 15:12:26 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <20140927014243.GA26666@omega> <54293279.5090103@xsilon.com> <54293B6C.7040800@gmail.com> <54293DD4.1090907@xsilon.com> <5429441C.5000302@gmail.com> <5429466F.4080506@gmail.com> <54295556.3030800@xsilon.com> <20140929131200.GA14608@omega> <20140929133048.GB14608@omega> <54295FA9.8030506@xsilon.com> <20140929133841.GA15176@omega> <542963F7.4030903@xsilon.com> <54296499.9080406@gmail.com>
In-Reply-To: <54296499.9080406@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org


On 29/09/14 14:54, Varka Bhadram wrote:
>
> On Monday 29 September 2014 07:21 PM, Simon Vincent wrote:
>> Sorry for the confusion. My problem is I am receiving all packets. 
>> PACKET_OTHERHOST does not seem to be dropped. A suggestion from Varka 
>> was to disable redirects however it now seems that this is not 
>> possible on a ipv6 interface.
>>
> Have you seen this [1].
>
> [1] 
> :http://linuxpoison.blogspot.in/2010/01/how-to-disable-icmp-redirects-in-linux.html
>
This does not seem to work. I get an error message on boot. error: 
"net.ipv6.conf.all.send_redirects" is an unknown key
