Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33721 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbbCRD3t (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 17 Mar 2015 23:29:49 -0400
Received: by lbbzq9 with SMTP id zq9so20866869lbb.0
        for <linux-wpan@vger.kernel.org>; Tue, 17 Mar 2015 20:29:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1426623946-6651-1-git-send-email-bradjc5@gmail.com>
References: <1426623946-6651-1-git-send-email-bradjc5@gmail.com>
Date: Wed, 18 Mar 2015 08:59:47 +0530
Message-ID: <CAEUmHyZRhZrpA2JDEGGRsv29QsL0rPcD+Y=Qz2PpsiwUTyY0iA@mail.gmail.com>
Subject: Re: [PATCHv3 bluetooth-next 0/2] Add CC2591 Support
From: Varka Bhadram <varkabhadram@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>

On 03/18/2015 01:55 AM, Brad Campbell wrote:
> Hi,
>
> I fixed the two issues that Alex pointed out and updated the
> commit message.
>
> Brad
>
> Brad Campbell (2):
>    cc2520: Do not store platform_data in spi_device
>    cc2520: Add support for CC2591 amplifier.
>
>   .../devicetree/bindings/net/ieee802154/cc2520.txt  |   4 +
>   drivers/net/ieee802154/cc2520.c                    | 150 +++++++++++++--------
>   include/linux/spi/cc2520.h                         |   1 +
>   3 files changed, 98 insertions(+), 57 deletions(-)
>
For the two patches..

Acked-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Varka Bhadram
