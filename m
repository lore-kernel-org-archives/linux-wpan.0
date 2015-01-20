Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49446 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbATOoI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 09:44:08 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NIH00DVJD4AAAA0@mailout2.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Tue, 20 Jan 2015 14:48:10 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1421750140-24760-1-git-send-email-alex.aring@gmail.com>
 <006b01d034a0$ff2e9900$fd8bcb00$@samsung.com> <20150120113231.GA3922@omega>
In-reply-to: <20150120113231.GA3922@omega>
Subject: Re: [PATCH wpan-tools 1/2] treewide: shorten commands
Date: Tue, 20 Jan 2015 14:43:53 +0000
Message-id: <009901d034bf$836e82c0$8a4b8840$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=utf-8
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Alexander Aring' <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 20/01/15 12:32, Alexander Aring wrote:
> On Tue, Jan 20, 2015 at 11:05:26AM +0000, Stefan Schmidt wrote:
>> Hello.
>>
>> On 20/01/15 11:35, Alexander Aring wrote:
>>> This patch shorten all commands. I had the idea to make a similarity
>> >from PIB/MIB values according the 802.15.4 names convention but this is
>>> bad for fast shell hacking. Mainly I remove the underscore and some
>>> additional information which are not necessary like "_addr" in
>>> "short_addr" and "extended_addr" and such things.
>>>
>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>> ---
>>>   src/info.c      | 10 +++++-----
>>>   src/interface.c | 20 ++++++++++----------
>>>   src/mac.c       | 10 +++++-----
>>>   src/phy.c       |  6 +++---
>>>   4 files changed, 23 insertions(+), 23 deletions(-)
>>
>> Hmm, it feels like you are going overboard with shorting things here. Why
>> is
>> the reason behind it? Just less typing? Shell auto completion would handle
>> this. :)
>>
>
> it's just less typing and I notice that the original iw command doesn't
> have an underscore in their commands.
>
> The first time when I hacked it, then I just took the same naming
> convention in kernel implementation which use the naming convention from
> 802.15.4 standard (without the beginning "MAC" and "PHY" keywords).

Having the naming the same in specs, kernel and the config util is 
actually good thing. This helps newcomers to understand them more easily.

> Now I am too lazy to always type pan_id short_addr, etc...

If the primary goal would be less typing the the binary should be named 
"i" and the options a, b, c, d :)

> Do you like to implement some completion stuff which can be shipped out
> optionally with the wpan-tools? :-)

Here is a start:
_iwpan()
{
     local cur prev opts
     COMPREPLY=()
     cur="${COMP_WORDS[COMP_CWORD]}"
     prev="${COMP_WORDS[COMP_CWORD-1]}"
     opts="--debug --version phy dev set channel tx_power cca_mode 
cca_ed_level pan_id short_addr max_frame_retries backoff_exponents 
max_csma_backoffs lbt info list interface add"

     COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
     return 0
}
complete -F _iwpan iwpan

Just drop this in a file called iwpan in  /etc/bash_completion.d/ and a 
simple command completion would work with bash. zsh user might want to 
do their own.

This has no fancy things like completing available wpan interfaces, etc 
but it completes all commands which was what you complained about for 
typing. :)

regards
Stefan Schmidt


