Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60371 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbbH0M3M (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 08:29:12 -0400
Subject: Re: [RFC bluetooth-next 00/21] mrf24j40: async rx/tx handling and new
 features
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DF0294.9040601@osg.samsung.com>
Date: Thu, 27 Aug 2015 14:29:08 +0200
MIME-Version: 1.0
In-Reply-To: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se

Hello.

On 13/08/15 14:22, Alexander Aring wrote:
> Hi,
>
> this patch series contains some cleanups, devicetree support, rx/tx async
> handling, threaded irq to hardirq, csma params settings, cca mode settings,
> cca energy detection levels, tx power settings and promiscuous mode settings.
>
> Also I add regmap support, the lowlevel spi calls are only used in hotpaths
> for handling receive/transmit and irq handling. There are also some many
> magic numbers, maybe we can introduce some register bits defines.
>
> First I will send this as RFC to get some respone if the patches looks fine
> and acceptable for mainline.

I waited for Alan to give some comments first here but he seems rather 
busy these days.

I struggled a while to hook up my mrf24j40ma module to a Pi B+ but it 
works now and I have been testing this patchset with it. Nothing 
problematic showed up and especially the updates for newer stack 
features are good to see for in-tree drivers.

You can have my

Tested-by: Stefan Schmidt <stefan@osg.samsung.com>

for the whole patchset. Review tags will individually while I go through it.

regards
Stefan Schmidt

