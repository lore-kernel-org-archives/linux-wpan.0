Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:65323 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbbESLS1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 07:18:27 -0400
Message-ID: <555B1C00.20900@xsilon.com>
Date: Tue, 19 May 2015 12:18:24 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: Kernel crash when using multiple interfaces
References: <5555EC72.6060302@xsilon.com> <20150515142026.GA11157@omega> <55560A88.1050903@xsilon.com> <20150516153329.GA31491@omega> <5559C58F.6010607@xsilon.com> <20150518140045.GA749@omega> <5559FFC2.9000309@xsilon.com> <20150518153712.GC749@omega> <20150518162727.GD749@omega>
In-Reply-To: <20150518162727.GD749@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

I am not sure why it was crashing yesterday. I have done a clean build 
today and it looks fine.
I would proceed with your patch and I will let you know if I see any 
problems in the future.

- Simon

On 18/05/15 17:27, Alexander Aring wrote:
> On Mon, May 18, 2015 at 05:37:12PM +0200, Alexander Aring wrote:
>> Hi,
>>
>> On Mon, May 18, 2015 at 04:05:38PM +0100, Simon Vincent wrote:
>>> With your patch I get either a "bad paging request" or a NULL pointer
>>> dereference crash at startup. I have not had any problems with my patch.
>>>
>>> Here are two stack traces I get.
>>>
>>> [   12.223057] [<c04da1b8>] (ieee802154_stop_queue) from [<c04d6d64>]
>>>
>>> or
>>>
>>> [   12.548824] [<c04da1b8>] (ieee802154_stop_queue) from [<c04d6d64>]
>> Both crashes in ieee802154_stop_queue, but we don't changed anything
>> which should affect the ieee802154_stop_queue in my or your fix.
>>
> Ah, it could be that it failed in ieee802154_tx after calling
> ieee802154_stop_queue. Are you sure that you don't miss some & for
> handling with pointers and then we have some invalid address?
>
> - Alex

