Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35239 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbbETPdK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 11:33:10 -0400
Received: by wicmx19 with SMTP id mx19so159388163wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 08:33:09 -0700 (PDT)
Date: Wed, 20 May 2015 17:33:06 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH atubs-fw 1/4] Revert "atusb/fw/usb/: enable MCU reset on
 USB bus reset after config selection"
Message-ID: <20150520153302.GK3978@omega>
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
 <1432127894-4760-2-git-send-email-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432127894-4760-2-git-send-email-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net, jlu@pengutronix.de

On Wed, May 20, 2015 at 03:18:11PM +0200, Stefan Schmidt wrote:
> This reverts commit 9b2696b8488dbc39b0fdcdefdfad775913cb6e2d.
> 
> With this patch ATUSB resets constantly when I use it in QEMU with USB
> poassthrough.
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

Acked-by: Alexander Aring <alex.aring@gmail.com>

Yea, atusb running now with qemu version behind 1.6.2 on my side :-)
I/We always had issues with newer qemu releases.

- Alex
