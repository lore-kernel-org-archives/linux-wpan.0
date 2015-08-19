Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58526 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbbHSP1G (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 19 Aug 2015 11:27:06 -0400
Subject: Re: [PATCH wpan-tools] mac: range checking for command accepting only
 0 or 1
References: <1439993604-8335-1-git-send-email-stefan@osg.samsung.com>
 <20150819142147.GA31917@omega> <55D49291.6090702@osg.samsung.com>
 <20150819143331.GB31917@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55D4A045.1040701@osg.samsung.com>
Date: Wed, 19 Aug 2015 17:27:01 +0200
MIME-Version: 1.0
In-Reply-To: <20150819143331.GB31917@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 19/08/15 16:33, Alexander Aring wrote:
> On Wed, Aug 19, 2015 at 04:28:33PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 19/08/15 16:22, Alexander Aring wrote:
>>> Hi Stefan,
>>>
>>> On Wed, Aug 19, 2015 at 04:13:24PM +0200, Stefan Schmidt wrote:
>>>> lbt and ackreq_default only accept 0or 1 as arguments which we did not
>>>> acount for so far. Testing invalid arguments and checking teh return
>>>> code uncovered this one.
>>>>
>>>> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>>>> ---
>>>>   src/mac.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/src/mac.c b/src/mac.c
>>>> index 76db58f..26c6fc5 100644
>>>> --- a/src/mac.c
>>>> +++ b/src/mac.c
>>>> @@ -175,6 +175,8 @@ static int handle_lbt_mode(struct nl802154_state *state,
>>>>   	mode = strtoul(argv[0], &end, 0);
>>>>   	if (*end != '\0')
>>>>   		return 1;
>>>> +	if (mode != 0 && mode != 1)
>>>> +		return 1;
>>>>   	NLA_PUT_U8(msg, NL802154_ATTR_LBT_MODE, mode);
>>>> @@ -202,6 +204,8 @@ static int handle_ackreq_default(struct nl802154_state *state,
>>>>   	ackreq = strtoul(argv[0], &end, 0);
>>>>   	if (*end != '\0')
>>>>   		return 1;
>>>> +	if (ackreq != 0 && ackreq != 1)
>>>> +		return 1;
>>> range checks should be handled by kernelspace. Currently we do a "!!var"
>>> conversion there.
>> Which is why any value > 0 gets set to 1 here.
>>
>>> Maybe we should change it there and accept "1" or "0".
>> I think that would indeed be better.
>>
>>> We should never handle "if a range is valid or not" inside userspace,
>>> otherwise other applications which talking to nl802154 can do a
>>> different handling then.
>> I disagree here. We should for sure do range checking in the kernel but we
>> should as well check for it in iwpan and get the return code right.
>>
> this should be handled by returning -EINVAL in the handler of nl802154. Try a:
>
> iwpan dev wpan0 set max_frame_retries 8
>
> which should always return "-EINVAL" inside nl802154.
>
> The return is:
>
> command failed: Invalid argument (-22)
>
>
>
> Is this okay? Or do you expect a different handling?
>
The problem is with lbt and and autoreq_default which are boolean. We 
accept things like 400 just fine here and bring it down to 1.
I'm going to fix this in nl802154 and leave it out of wpan-tools.

regards
Stefan Schmidt
