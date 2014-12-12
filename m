Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:39017 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966399AbaLLOiF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 09:38:05 -0500
Message-ID: <548AFDCA.8060805@datenfreihafen.org>
Date: Fri, 12 Dec 2014 15:38:02 +0100
From: Stefan Schmidt <stefan@datenfreihafen.org>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-misc 1/2] website: fix milestone table name
References: <1418394106-12799-1-git-send-email-alex.aring@gmail.com> <548AFC69.9080106@datenfreihafen.org> <20141212143609.GC381@omega>
In-Reply-To: <20141212143609.GC381@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 12/12/14 15:36, Alexander Aring wrote:
> Hi,
>
> On Fri, Dec 12, 2014 at 03:32:09PM +0100, Stefan Schmidt wrote:
>> Hello.
>>
>> On 12/12/14 15:21, Alexander Aring wrote:
>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>> ---
>>>  website/index.txt | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/website/index.txt b/website/index.txt
>>> index a7ab4bb..5a3252b 100644
>>> --- a/website/index.txt
>>> +++ b/website/index.txt
>>> @@ -114,7 +114,7 @@ Currently a rework of 802.15.4 subsystem is in progress.
>>>  
>>>  The rework will contains a new netlink API and a general handling about frame creation and parsing.
>>>  
>>> -.Supported 802.15.4 Hardware
>>> +.Milestones
>>>  [options="header"]
>>>  |=======================================
>>>  |Milestone        | Description | state
>> Both patches look good. I guess we don't do any Reviewed-By or Acked-By
>> annotation here as you will directly apply them. :)
>>
> yea, I can change the behaviour if you like I forget some "Reported-by: ...".
> Isn't the linux kernel here. Only some small repo for website, logos,
> etc..
>
> I hope that's ok. Alternative would be I do some force push and fix that. :-)
Nah, keep it like you do right now. Was just wondering. :)

regards
Stefan Schmidt
