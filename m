Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34412 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751939AbcELAS0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 20:18:26 -0400
Subject: Re: [PATCH wpan-tools 1/2] nl802154: update nl802154.h
References: <1462959979-6755-1-git-send-email-aar@pengutronix.de>
 <57334ACD.3040708@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <cb55d018-0a78-a4c2-db16-c0b8cc17f2b1@pengutronix.de>
Date: Thu, 12 May 2016 02:18:24 +0200
MIME-Version: 1.0
In-Reply-To: <57334ACD.3040708@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hi,

On 05/11/2016 05:07 PM, Stefan Schmidt wrote:
> Hello.
> 
> On 11/05/16 11:46, Alexander Aring wrote:
>> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> 
> You could have explained here that this update brings the defines needed for netns and later on llsec support.
> But after all its only a sync of the header file from kernel to userspace utility.
> 

Yea, it's just a update and nobody should touch the nl802154 header by
any editor here, it's just a copy from kernel.

Maybe I should use the commit msg like [0].

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/jberg/iw.git/commit/?id=f45d4583f14acf115aa248af0caee80a3dfa98d3
