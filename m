Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:57539 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3KYI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Apr 2019 06:24:08 -0400
Subject: Re: pull-request: ieee802154 for net 2019-04-25
References: <20190425160311.19767-1-stefan@datenfreihafen.org>
 <20190429.182109.2278488103649846421.davem@davemloft.net>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <04de2423-65bb-debc-2a8f-addb401b006d@datenfreihafen.org>
Date: Tue, 30 Apr 2019 12:24:05 +0200
MIME-Version: 1.0
In-Reply-To: <20190429.182109.2278488103649846421.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

On 30.04.19 00:21, David Miller wrote:
> From: Stefan Schmidt <stefan@datenfreihafen.org>
> Date: Thu, 25 Apr 2019 18:03:11 +0200
> 
>> An update from ieee802154 for your *net* tree.
>>
>> Another fix from Kangjie Lu to ensure better checking regmap updates in the
>> mcr20a driver. Nothing else I have pending for the final release.
>>
>> If there are any problems let me know.
> 
> Pulled, thanks Stefan.
> 
>> During the preparation of this pull request a workflow question on
>> my side came up and wonder if you (or some subsystem maintainer
>> sending you pull requests) does have a comment on this. The
>> ieee802154 subsystem has a low activity in the number of patches
>> coming through it. I still wanted to pull from your net tree
>> regularly to test if changes have implications to it. During this
>> pulls I often end up with merge of the remote tracking branch. Which
>> in the end could mean that I would have something like 3-4 merge
>> commits in my tree with only one actual patch I want to send over to
>> you. Feels and looks kind of silly to be honest.
>>
>> How do other handle this? Just merge once every rc? Merge just
>> before sending a pull request? Never merge, wait for Dave to pull
>> and merge and do a pull of his tree directly afterwards?
> 
> I would say never pull from the net tree until right after I pull your
> tree and thus you can do a clean fast-forward merge.

Thanks, I will try to work like this. Normally there should be no
overlap on ieee802154 patches I get that would need a newer pull from
net. Seems I was to eager to always work against your latest. :-)

I pulled now after your merge of my request and will do again after the
next. Will see how it will work out for me.

> If you want to test, right before you send me a pull request do a test
> pull into a local throw-away branch.

That is what I have been doing so far.

> Otherwise I'll handle conflicts and merge issues.

Thanks. When I see a merge conflict in my pre-pull-request testing I
will include my merge result in the pull request.

regards
Stefan Schmidt
