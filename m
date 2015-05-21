Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34862 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135AbbEUPg3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 21 May 2015 11:36:29 -0400
Received: by wicmx19 with SMTP id mx19so19211140wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 21 May 2015 08:36:28 -0700 (PDT)
Date: Thu, 21 May 2015 17:36:22 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 0/3] ATUSB driver updates
Message-ID: <20150521153618.GA901@omega>
References: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, May 21, 2015 at 04:51:34PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> Some updates for the atusb driver.
> 
> Checking for minimum firmware version now that we have a public release. It
> only warns if an old version is used for now but updating in encouraged.
> 
> The newest firmware also handles AACK handling so we can indicate this to the
> stack.
> 
> The last patch just sets the default ed level like the other drivers. Better
> ed handling for atusb is planned for the future.
> 
> Stefan Schmidt (3):
>   ieee802154/atusb: Warn about outdated device firmware.
>   ieee802154/atusb: Mark driver as AACK enabled in hardware.
>   ieee802154/atusb: Set default ed level to 0xbe like the rest of these
>     drivers
> 
>  drivers/net/ieee802154/atusb.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Acked-by: Alexander Aring <alex.aring@gmail.com>

on the complete series.

- Alex

