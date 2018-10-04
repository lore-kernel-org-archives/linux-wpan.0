Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53966 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeJDR14 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Oct 2018 13:27:56 -0400
Subject: Re: [PATCHv2 wpan-tools] wpan-hwsim: hardware simulator configuration
 utility
References: <20180930215234.4679-1-aring@mojatatu.com>
 <d7ddf133-f8ff-e372-d722-14daa0de4545@datenfreihafen.org>
 <20181003143146.hf3qcdlxbvupt4yg@x220t>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <8b402bbe-71b5-c196-4a00-e50314464d78@datenfreihafen.org>
Date: Thu, 4 Oct 2018 12:35:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181003143146.hf3qcdlxbvupt4yg@x220t>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 03/10/2018 16:31, Alexander Aring wrote:
> Hi,
> 
> On Wed, Oct 03, 2018 at 10:14:09AM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 30/09/2018 23:52, Alexander Aring wrote:
>>> This patch adds initial support for wpan-hwsim utility to control the
>>> mac802154_hwsim driver over netlink.
>>>
>>> Signed-off-by: Alexander Aring <aring@mojatatu.com>
>>> ---
>>>
>>> Forgot if I ever send v2 but my local change has the last complain.
>>> So I resend.
>>>
>>> changes since v2:
>>> - help and version both do not need an argument, please use no_argument
>>> - printf("wpan-hwsim " PACKAGE_VERSION "\n");
>>
>> Patch has been applied to wpan-tools. Thanks for fixing up my review
>> comments.
>>
>> Seems we want to get out a new wpan-tools release in the next weeks to
>> have this utility available. I will see what I can do.
>>
> 
> wait please for a fix... I forgot that dot longarg needs no_argument as
> well...

No problem. We have time to get fixes in. Juts wanted to make sure we
get a new release with the hwsim utility out to match the latest kernel
release.

> I begin to hate that interface. I need to define it for short with ':'
> and then again for long in this struct. I do short sometimes only...
> I will never do long args again, I fall into mistakes.

Yeah, getopt is not the nicest interface, but doing command line option
handling by hand is not nice either.

regards
Stefan Schmidt
