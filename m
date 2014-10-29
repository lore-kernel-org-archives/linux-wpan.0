Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35579 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbaJ2Dfl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 23:35:41 -0400
Received: by mail-pd0-f181.google.com with SMTP id y10so2076429pdj.40
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 20:35:41 -0700 (PDT)
Message-ID: <54505FDF.80900@gmail.com>
Date: Wed, 29 Oct 2014 09:02:47 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 04/17] mac802154: ops: declare channel
 and page as u8
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com> <1414516892-4107-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-5-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alan Ott <alan@signal11.us>

On 10/28/2014 10:51 PM, Alexander Aring wrote:
> The range of channel and page fits into an unsigned byte range. This
> patch changes the set_channel parameter definitions for channel and
> page to u8.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Cc: Alan Ott <alan@signal11.us>
> ---
>   drivers/net/ieee802154/at86rf230.c | 8 ++++----
>   drivers/net/ieee802154/cc2520.c    | 2 +-
>   drivers/net/ieee802154/fakelb.c    | 2 +-
>   drivers/net/ieee802154/mrf24j40.c  | 3 +--
>   include/net/mac802154.h            | 5 ++---
>   5 files changed, 9 insertions(+), 11 deletions(-)
>
For cc2520 driver change

Acked-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Regards,
Varka Bhadram.

