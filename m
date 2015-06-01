Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36039 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbbFAEQA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 00:16:00 -0400
Received: by pdjm12 with SMTP id m12so15177329pdj.3
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2015 21:16:00 -0700 (PDT)
Message-ID: <556BDC68.1000608@gmail.com>
Date: Mon, 01 Jun 2015 09:45:36 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] mac802154: add trace functionality for
 driver ops
References: <1433130997-5148-1-git-send-email-varkab@cdac.in>
In-Reply-To: <1433130997-5148-1-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

On 06/01/2015 09:26 AM, Varka Bhadram wrote:

> This patch adds trace events for driver operations.
>
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>   net/mac802154/Makefile     |    4 +-
>   net/mac802154/driver-ops.h |   92 ++++++++++++---
>   net/mac802154/trace.c      |    9 ++
>   net/mac802154/trace.h      |  272 ++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 362 insertions(+), 15 deletions(-)
>   create mode 100644 net/mac802154/trace.c
>   create mode 100644 net/mac802154/trace.h
>
(...)

> +TRACE_EVENT(802154_drv_set_extended_addr,
> +	TP_PROTO(struct ieee802154_local *local, __le64 extended_addr),
> +	TP_ARGS(local, extended_addr),
> +	TP_STRUCT__entry(
> +		LOCAL_ENTRY
> +		__field(__le64, extended_addr)
> +	),
> +	TP_fast_assign(
> +		LOCAL_ASSIGN;
> +		__entry->extended_addr = extended_addr;
> +	),
> +	TP_printk(LOCAL_PR_FMT ", extended addr: %0xllx", LOCAL_PR_ARG,

Its my bad. Fix to be done in the format specifier. I will send v2.

Thanks


-- 
Varka Bhadram

