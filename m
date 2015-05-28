Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33032 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbbE1IUk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 04:20:40 -0400
Received: by wgez8 with SMTP id z8so29547934wge.0
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 01:20:39 -0700 (PDT)
Date: Thu, 28 May 2015 10:20:33 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next] mac802154: add trace functionality for
 driver ops
Message-ID: <20150528082032.GA1114@omega>
References: <1432715090-23345-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1432715090-23345-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi,

I did not test yet, but found some review things.

On Wed, May 27, 2015 at 01:54:50PM +0530, Varka Bhadram wrote:
...
> +		__field(bool, mode)
> +	),
> +	TP_fast_assign(
> +		LOCAL_ASSIGN;
> +		__entry->mode = mode;
> +	),
> +	TP_printk(LOCAL_PR_FMT ", lbt mode: %s", LOCAL_PR_ARG,
> +		  BOOL_TO_STR(__entry->mode))
> +);
> +
> +TRACE_EVENT(802154_drv_set_short_addr,
> +	TP_PROTO(struct ieee802154_local *local, __le16 short_addr),
> +	TP_ARGS(local, short_addr),
> +	TP_STRUCT__entry(
> +		LOCAL_ENTRY
> +		__field(__le16, short_addr)
> +	),
> +	TP_fast_assign(
> +		LOCAL_ASSIGN;
> +		__entry->short_addr = short_addr;
> +	),
> +	TP_printk(LOCAL_PR_FMT ", sa: 0x%04x", LOCAL_PR_ARG,
> +		  __entry->short_addr)

care about byteorder here. you need cpu_to_le16 in the format string,
please.


> +);
> +
> +TRACE_EVENT(802154_drv_set_pan_id,
> +	TP_PROTO(struct ieee802154_local *local, __le16 pan_id),
> +	TP_ARGS(local, pan_id),
> +	TP_STRUCT__entry(
> +		LOCAL_ENTRY
> +		__field(__le16, pan_id)
> +	),
> +	TP_fast_assign(
> +		LOCAL_ASSIGN;
> +		__entry->pan_id = pan_id;
> +	),
> +	TP_printk(LOCAL_PR_FMT ", pan id: 0x%04x", LOCAL_PR_ARG,
> +		  __entry->pan_id)

same here.

> +);
> +
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
> +	TP_printk(LOCAL_PR_FMT ", extended addr %llx", LOCAL_PR_ARG,
> +		  __entry->extended_addr)
> +);
> +

same here.

> +TRACE_EVENT(802154_drv_set_pan_coord,
> +	TP_PROTO(struct ieee802154_local *local, bool is_coord),
> +	TP_ARGS(local, is_coord),
> +	TP_STRUCT__entry(
> +		LOCAL_ENTRY
> +		__field(bool, is_coord)
> +	),
> +	TP_fast_assign(
> +		LOCAL_ASSIGN;
> +		__entry->is_coord = is_coord;
> +	),
> +	TP_printk(LOCAL_PR_FMT ", is_coord: %s", LOCAL_PR_ARG,
> +		  BOOL_TO_STR(__entry->is_coord))
> +);
> +

- Alex
