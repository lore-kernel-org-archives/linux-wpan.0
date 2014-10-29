Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:45741 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbaJ2Dek (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 23:34:40 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so2082834pdj.38
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 20:34:40 -0700 (PDT)
Message-ID: <54505F9A.3030906@gmail.com>
Date: Wed, 29 Oct 2014 09:01:38 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 03/17] mac802154: declare struct ieee802154_ops
 as const
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com> <1414516892-4107-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-4-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alan Ott <alan@signal11.us>

On 10/28/2014 10:51 PM, Alexander Aring wrote:
> The ieee802154_ops structure should be never changed during runtime.
> This patch declare this structure as const to avoid a runtime change.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Cc: Alan Ott <alan@signal11.us>
> ---
>   drivers/net/ieee802154/at86rf230.c | 2 +-
>   drivers/net/ieee802154/cc2520.c    | 2 +-
>   drivers/net/ieee802154/fakelb.c    | 2 +-
>   drivers/net/ieee802154/mrf24j40.c  | 2 +-
>   include/net/mac802154.h            | 2 +-
>   net/mac802154/ieee802154_i.h       | 2 +-
>   net/mac802154/main.c               | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)

For CC2520 driver

Acked-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Regards,
Varka Bhadram.

