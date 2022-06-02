Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89600C433EF
	for <linux-wpan@archiver.kernel.org>; Thu,  2 Jun 2022 15:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiFBPgD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiFBPgC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Jun 2022 11:36:02 -0400
X-Greylist: delayed 515 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 08:36:00 PDT
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACB5138A1
        for <linux-wpan@vger.kernel.org>; Thu,  2 Jun 2022 08:36:00 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fc30.dip0.t-ipconnect.de [79.249.252.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2A0D2CED1A;
        Thu,  2 Jun 2022 17:27:24 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH bluetooth-next 0/3] net: 6lowpan: simplify lookup by nhc
 id
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZK1uWjxmvJUBPaUdMvj8B-p=TtRKTUwQ0szCgLhh+7CcA@mail.gmail.com>
Date:   Thu, 2 Jun 2022 17:27:23 +0200
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <aahringo@redhat.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <89A5D478-0611-4F20-B2BF-3CF3E3E82F9C@holtmann.org>
References: <20220428030534.3220410-1-aahringo@redhat.com>
 <06164dbe-3c11-c627-0929-a399414c01bf@datenfreihafen.org>
 <CABBYNZKCoj+W1MygU4eZZxGVSrWuRfEWx-fLOXvV-vXXY72vmw@mail.gmail.com>
 <3b5d28c4-1877-ba8f-dcb3-d5c3cbc06a1f@datenfreihafen.org>
 <CABBYNZK1uWjxmvJUBPaUdMvj8B-p=TtRKTUwQ0szCgLhh+7CcA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan,

>>>>> this patch series removes the rb data structure for looking up a nhc by
>>>>> nhc id. Instead we using the existing nexthdr lookup array by iterating
>>>>> over it and find the right nhc by nhc id. It's simply not worth it to
>>>>> use such complex handling for such small amount of nhc. As we only
>>>>> support nhc ids which fits into 1 byte and there are not two byte nhc
>>>>> ids values specified yet, we let the nhc layer only handle 1 byte values.
>>>>> If there is the need for 2 byte nhc values we can add support for it.
>>>>> 
>>>>> - Alex
>>>>> 
>>>>> Alexander Aring (3):
>>>>> net: 6lowpan: remove const from scalars
>>>>> net: 6lowpan: use array for find nhc id
>>>>> net: 6lowpan: constify lowpan_nhc structures
>>>> 
>>>> Marcel, Luiz, are you still picking up generic 6lowpan patches or only
>>>> the ones for bluetooth?
>>>> 
>>>> These three have been around for over a month and acked by me and Jukka,
>>>> but I can't find them anywhere in bluetooth-next or Linus tree.
>>>> 
>>>> If 6lowpan is of less concern for you I can route them through my
>>>> ieee80254 tree as well.
>>> 
>>> Up to you, I was not aware they normally were merged thru
>>> bluetooth-next but I would be fine merging those as well.
>> 
>> If you and Marcel don't mind I would like to switch this over to being
>> merged through ieee802154. Mostly because 6lowpan is vital for the 15.4
>> work we have.
>> 
>> With Jukka stepping down from co-maintaining this part (thanks a lot for
>> your work!) this will most likely be reviewed by Alex and me anyway.
>> 
>> We still need to ensure that patches are hitting wpan as well as
>> bluetooth mailing list, but the MAINTAINERS file handles this already.
>> 
>> Let me know if you are unhappy with the switch. If not I will start with
>> merging these three as well as the MAINTAINERS update from Jukka.
> 
> I have no problem with that.

go for it. Lets just keep the mailing list in MAINTAINERS file so we are aware of patches in this area.

Regards

Marcel

