Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54902 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbcLEHvj (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Dec 2016 02:51:39 -0500
Subject: Re: [PATCH] linux-firmware: update firmware file for atusb
References: <1480857912-12695-1-git-send-email-stefan@datenfreihafen.org>
 <1480911392.2629.12.camel@decadent.org.uk>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <423cf0a2-9698-c5e8-c8c2-6dacd5ee25a0@datenfreihafen.org>
Date: Mon, 5 Dec 2016 08:51:37 +0100
MIME-Version: 1.0
In-Reply-To: <1480911392.2629.12.camel@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>, "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

On 05.12.2016 05:16, Ben Hutchings wrote:
> On Sun, 2016-12-04 at 14:25 +0100, Stefan Schmidt wrote:
>> Update to newly released 0.3 version while also adding another
>> file for the slightly different Atmel Raven USB dongle to be
>> supported by the same kernel driver.
>>
>>> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
>> ---
>>  WHENCE              |   4 +++-
>>  atusb/ChangeLog     |   9 ++++++---
>>  atusb/atusb-0.3.dfu | Bin 0 -> 6042 bytes
>>  atusb/rzusb-0.3.bin | Bin 0 -> 6058 bytes
>>  4 files changed, 9 insertions(+), 4 deletions(-)
>>  create mode 100755 atusb/atusb-0.3.dfu
>>  create mode 100755 atusb/rzusb-0.3.bin
> 
> Permissions are wrong.

Oops, this slipped through. Thanks for catching it!

>> diff --git a/WHENCE b/WHENCE
>> index d021c40..e28cfd8 100644
>> --- a/WHENCE
>> +++ b/WHENCE
>> @@ -3129,7 +3129,9 @@ Licence: Redistributable. See LICENCE.nvidia for details
>>  Driver: atusb - ATUSB IEEE 802.15.4 transceiver driver
>>  
>>  File: atusb/atusb-0.2.dfu
>> -Version: 0.2
>> +File: atusb/atusb-0.3.dfu
>> +File: atusb/rzusb-0.3.bin
>> +Version: 0.3
> [...]
> 
> Each Version field refers to the previous File field, so you should
> leave 0.2 there for the old file and specify 0.3 for each of the new
> files.

Ah, I haven't realised that it is meant like this.

I fixed both problems now and sent a v2 patch. Thanks for the fast review.

regards
Stefan Schmidt
