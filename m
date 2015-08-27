Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46071 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752033AbbH0MdJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 08:33:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id DBDFB2080A
	for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2015 08:33:08 -0400 (EDT)
In-Reply-To: <55DF0294.9040601@osg.samsung.com>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com> <55DF0294.9040601@osg.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC bluetooth-next 00/21] mrf24j40: async rx/tx handling and new features
From: Alan Ott <alan@signal11.us>
Date: Thu, 27 Aug 2015 08:33:06 -0400
Message-ID: <E23667B1-12D2-4689-866F-B6F7DA4F385A@signal11.us>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jonatan@myeden.se



On August 27, 2015 8:29:08 AM EDT, Stefan Schmidt <stefan@osg.samsung.com> wrote:
>Hello.
>
>On 13/08/15 14:22, Alexander Aring wrote:
>> Hi,
>>
>> this patch series contains some cleanups, devicetree support, rx/tx
>async
>> handling, threaded irq to hardirq, csma params settings, cca mode
>settings,
>> cca energy detection levels, tx power settings and promiscuous mode
>settings.
>>
>> Also I add regmap support, the lowlevel spi calls are only used in
>hotpaths
>> for handling receive/transmit and irq handling. There are also some
>many
>> magic numbers, maybe we can introduce some register bits defines.
>>
>> First I will send this as RFC to get some respone if the patches
>looks fine
>> and acceptable for mainline.
>
>I waited for Alan to give some comments first here but he seems rather 
>busy these days.
>
>I struggled a while to hook up my mrf24j40ma module to a Pi B+ but it 
>works now and I have been testing this patchset with it. Nothing 
>problematic showed up and especially the updates for newer stack 
>features are good to see for in-tree drivers.
>
>You can have my
>
>Tested-by: Stefan Schmidt <stefan@osg.samsung.com>
>
>for the whole patchset. Review tags will individually while I go
>through it.
>
>regards
>Stefan Schmidt

Thanks Stefan. I've been on the road. Hopefully I can get some time this weekend to get a proper response out.

Alan.


