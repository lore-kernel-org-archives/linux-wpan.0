Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailsender.cdac.in ([196.1.113.117]:45427 "EHLO
	mailsender.cdac.in" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbbE2GVQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 02:21:16 -0400
Message-ID: <55680526.5000403@cdac.in>
Date: Fri, 29 May 2015 11:50:22 +0530
From: Varka Bhadram <varkab@cdac.in>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next] mac802154: add trace functionality for driver
 ops
References: <1432715090-23345-1-git-send-email-varkab@cdac.in> <20150528082032.GA1114@omega> <5567F9C4.5080904@gmail.com> <20150529061923.GA1467@omega>
In-Reply-To: <20150529061923.GA1467@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org

On 05/29/2015 11:49 AM, Alexander Aring wrote:
> On Fri, May 29, 2015 at 11:01:48AM +0530, Varka Bhadram wrote:
>> Hi Alex,
>>
>> On 05/28/2015 01:50 PM, Alexander Aring wrote:
>>
>>> Hi,
>>>
>>> I did not test yet, but found some review things.
>> Please test it.
>>
>>> On Wed, May 27, 2015 at 01:54:50PM +0530, Varka Bhadram wrote:
>>> ...
>>>> +		__field(bool, mode)
>>>> +	),
>>>> +	TP_fast_assign(
>>>> +		LOCAL_ASSIGN;
>>>> +		__entry->mode = mode;
>>>> +	),
>>>> +	TP_printk(LOCAL_PR_FMT ", lbt mode: %s", LOCAL_PR_ARG,
>>>> +		  BOOL_TO_STR(__entry->mode))
>>>> +);
>>>> +
>>>> +TRACE_EVENT(802154_drv_set_short_addr,
>>>> +	TP_PROTO(struct ieee802154_local *local, __le16 short_addr),
>>>> +	TP_ARGS(local, short_addr),
>>>> +	TP_STRUCT__entry(
>>>> +		LOCAL_ENTRY
>>>> +		__field(__le16, short_addr)
>>>> +	),
>>>> +	TP_fast_assign(
>>>> +		LOCAL_ASSIGN;
>>>> +		__entry->short_addr = short_addr;
>>>> +	),
>>>> +	TP_printk(LOCAL_PR_FMT ", sa: 0x%04x", LOCAL_PR_ARG,
>>>> +		  __entry->short_addr)
>>> care about byteorder here. you need cpu_to_le16 in the format string,
>>> please.
>>>
>>>
> meant s/cpu_to_le16/le16_to_cpu/

Got it.

-- 
Varka Bhadram


-------------------------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
-------------------------------------------------------------------------------------------------------------------------------

