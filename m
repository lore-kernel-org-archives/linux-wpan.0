Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38577 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbbH0RpM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Aug 2015 13:45:12 -0400
Received: by wicgk12 with SMTP id gk12so16446252wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2015 10:45:11 -0700 (PDT)
Date: Thu, 27 Aug 2015 19:45:08 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 09/21] mrf24j40: add regmap support
Message-ID: <20150827174504.GB686@omega>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
 <1439468568-22288-10-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1439468568-22288-10-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com

On Thu, Aug 13, 2015 at 02:22:36PM +0200, Alexander Aring wrote:
> This patch introduce regmap support for short and long address space of
> mrf24j40. It's only possible to use regmap_read/write/update_bits for
> long address range. This is because I added lowlevel bus operation
> because the write operation need to set the 12th bit to mark a register
> write, but regmap only supports to set bits for register write access in
> the first byte. We use other regmap register functions than

should be "We don't use other regmap functions than ...."

> read/write/update_bits, so this should be fine.
> 

- Alex
