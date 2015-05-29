Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32880 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbbE2FcN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 01:32:13 -0400
Received: by padbw4 with SMTP id bw4so43223916pad.0
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 22:32:13 -0700 (PDT)
Message-ID: <5567F9C4.5080904@gmail.com>
Date: Fri, 29 May 2015 11:01:48 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next] mac802154: add trace functionality for driver
 ops
References: <1432715090-23345-1-git-send-email-varkab@cdac.in> <20150528082032.GA1114@omega>
In-Reply-To: <20150528082032.GA1114@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Alex,

On 05/28/2015 01:50 PM, Alexander Aring wrote:

> Hi,
>
> I did not test yet, but found some review things.

Please test it.

> On Wed, May 27, 2015 at 01:54:50PM +0530, Varka Bhadram wrote:
> ...
>> +		__field(bool, mode)
>> +	),
>> +	TP_fast_assign(
>> +		LOCAL_ASSIGN;
>> +		__entry->mode = mode;
>> +	),
>> +	TP_printk(LOCAL_PR_FMT ", lbt mode: %s", LOCAL_PR_ARG,
>> +		  BOOL_TO_STR(__entry->mode))
>> +);
>> +
>> +TRACE_EVENT(802154_drv_set_short_addr,
>> +	TP_PROTO(struct ieee802154_local *local, __le16 short_addr),
>> +	TP_ARGS(local, short_addr),
>> +	TP_STRUCT__entry(
>> +		LOCAL_ENTRY
>> +		__field(__le16, short_addr)
>> +	),
>> +	TP_fast_assign(
>> +		LOCAL_ASSIGN;
>> +		__entry->short_addr = short_addr;
>> +	),
>> +	TP_printk(LOCAL_PR_FMT ", sa: 0x%04x", LOCAL_PR_ARG,
>> +		  __entry->short_addr)
> care about byteorder here. you need cpu_to_le16 in the format string,
> please.
>
>
>> +);
>> +
>> +TRACE_EVENT(802154_drv_set_pan_id,
>> +	TP_PROTO(struct ieee802154_local *local, __le16 pan_id),
>> +	TP_ARGS(local, pan_id),
>> +	TP_STRUCT__entry(
>> +		LOCAL_ENTRY
>> +		__field(__le16, pan_id)
>> +	),
>> +	TP_fast_assign(
>> +		LOCAL_ASSIGN;
>> +		__entry->pan_id = pan_id;
>> +	),
>> +	TP_printk(LOCAL_PR_FMT ", pan id: 0x%04x", LOCAL_PR_ARG,
>> +		  __entry->pan_id)
> same here.
>
>> +);
>> +
>> +TRACE_EVENT(802154_drv_set_extended_addr,
>> +	TP_PROTO(struct ieee802154_local *local, __le64 extended_addr),
>> +	TP_ARGS(local, extended_addr),
>> +	TP_STRUCT__entry(
>> +		LOCAL_ENTRY
>> +		__field(__le64, extended_addr)
>> +	),
>> +	TP_fast_assign(
>> +		LOCAL_ASSIGN;
>> +		__entry->extended_addr = extended_addr;
>> +	),
>> +	TP_printk(LOCAL_PR_FMT ", extended addr %llx", LOCAL_PR_ARG,
>> +		  __entry->extended_addr)
>> +);
>> +
> same here.
>
>> +TRACE_EVENT(802154_drv_set_pan_coord,
>> +	TP_PROTO(struct ieee802154_local *local, bool is_coord),
>> +	TP_ARGS(local, is_coord),
>> +	TP_STRUCT__entry(
>> +		LOCAL_ENTRY
>> +		__field(bool, is_coord)
>> +	),
>> +	TP_fast_assign(
>> +		LOCAL_ASSIGN;
>> +		__entry->is_coord = is_coord;
>> +	),
>> +	TP_printk(LOCAL_PR_FMT ", is_coord: %s", LOCAL_PR_ARG,
>> +		  BOOL_TO_STR(__entry->is_coord))
>> +);
>> +

Ok i will do.

Thanks.

-- 
Varka Bhadram

