Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59325 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbcC3VAL (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 30 Mar 2016 17:00:11 -0400
Subject: Re: 802.15.4G support?
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
 <20160228140659.GA17980@omega> <28981.1457015214@obiwan.sandelman.ca>
 <20160304083528.GA1525@omega> <24416.1457106776@obiwan.sandelman.ca>
 <20160304163749.GA21798@omega> <15462.1457122604@obiwan.sandelman.ca>
 <56E6D9F6.70308@osg.samsung.com> <25857.1457997112@obiwan.sandelman.ca>
 <CAH+RWqHFKj1joOtNVpP2WR=VO_mOekfek6E9EcEtFnsDj5PHCQ@mail.gmail.com>
 <56FB943B.3030105@osg.samsung.com>
 <CAH+RWqELkRuoaF1VRtR5XKibLcz9hod5KzUuu8iBo6mrBJ1JaQ@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56FC3E52.3080202@osg.samsung.com>
Date: Wed, 30 Mar 2016 23:00:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAH+RWqELkRuoaF1VRtR5XKibLcz9hod5KzUuu8iBo6mrBJ1JaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Remi Philippe <remi@linqio.com>
Cc: Michael Richardson <mcr@sandelman.ca>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 30/03/16 19:18, Remi Philippe wrote:
> On Wed, Mar 30, 2016 at 12:54 PM, Stefan Schmidt <stefan@osg.samsung.com> wrote:
>> Hello.
>>
>> On 15/03/16 06:19, Remi Philippe wrote:
>>> On Tue, Mar 15, 2016 at 3:11 AM, Michael Richardson <mcr@sandelman.ca>
>>> wrote:
>>>> Stefan Schmidt <stefan@osg.samsung.com> wrote:
>>>>       > 2) If the 802.15.4g node uses a SUN PHY with a 2047 byte MTU we
>>>> can run into
>>>>       > trouble with normal nodes only able to handle 127. So far there is
>>>> nothing
>>>>       > specified to handle this case. Michael is proposing to use 6lo ND
>>>> for this
>>>>       > and record the MTU value for this neighbour in the l2 nd cache.
>>>> Something
>>>>       > that would certainly work but would need specing and implementing.
>>>> I see this
>>>>       > as a mid term goal we want to have. Anyone going to work on this?
>>>>
>>>> It's not even clear to me that ND can do this.
>>>> I still propose that we want to have a space in the l2 or l3 ND cache for
>>>> this info.  It could well go in the L3 cache because it is really a
>>>> statement
>>>> about how the 6lowpan layer should fragment.
>>>>
>>>>       > 3) Until 2) is done I would suggest we add a config option
>>>> "802.15.4g with
>>>>       > SUN PHY" which will change the hardcoded MTU from 127 to 2047 and
>>>> will thus
>>>>       > only work for a 15.g with SUN PHY only network. No interop as we
>>>> have no way
>>>>       > of knowing. The option would be disabled by default and the help
>>>> text needs
>>>>       > to mention the drawbacks. Once we have 2) in place we can remove
>>>> this.
>>>>
>>>> Couldn't we use "ifconfig blah0 mtu 2047"?
>>> Maybe we should do both, have a flag to specify the PHY type as the
>>> PHY header is slightly different in15.4g MR-FSK to support for mode
>>> switch, data whitening... it needs to support 2 octets header (page 52
>>> of the 802.15.4g-2012 spec) it can also lock the max MTU supported for
>>> the media. And allow to change the MTU from command line.
>>>
>> Did you move on with this? If you ahve any patches let us know. We are
>> happily going to review them.
>>
>> regards
>> Stefan Schmidt
> We're still fixing some issues on the AT86RF215 (some timing issues
> and bit swapping), then we'll go for the configurable MTU and then
> look into the 15.4G. So work in progress, we'll send the patches once
> we have something stable!

OK, cool, so its being worked on. Was just going through my pending 
mails and wanted to see if there was anything blocking you from our side. :)

regards
Stefan Schmidt
