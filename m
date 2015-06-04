Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailsender.cdac.in ([196.1.113.117]:34864 "EHLO
	mailsender.cdac.in" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbFDHMA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 03:12:00 -0400
Message-ID: <556FFA0D.604@cdac.in>
Date: Thu, 04 Jun 2015 12:41:09 +0530
From: Varka Bhadram <varkab@cdac.in>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-tools] interface: fix interface type info
References: <1433310698-14691-1-git-send-email-varkab@cdac.in> <20150604070455.GA1232@omega>
In-Reply-To: <20150604070455.GA1232@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org

On 06/04/2015 12:34 PM, Alexander Aring wrote:
> On Wed, Jun 03, 2015 at 11:21:38AM +0530, Varka Bhadram wrote:
>> Signed-off-by: Varka Bhadram <varkab@cdac.in>
>> ---
>>   src/interface.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/interface.c b/src/interface.c
>> index e501763..1c59876 100644
>> --- a/src/interface.c
>> +++ b/src/interface.c
>> @@ -28,7 +28,7 @@ const char *iftype_name(enum nl802154_iftype iftype)
>>   	case NL802154_IFTYPE_COORD:
>>   		return "coordinator";
>>   	default:
>> -		sprintf(modebuf, "Unknown mode (%d)", iftype);
>> +		sprintf(modebuf, "Invalid iftype (%d)", iftype);
>>   		return modebuf;
> This error message is like iw tool. I don't know how we strict we should
> make the behaviour like wireless here. I think it's okay to change that.
>
> But note there is also a "modebuf" and you changed "Unknown mode ..." to
> "Unknown iftype..." if you want to change it then I would assume to make
> everything to "iftypeFOOBAR". I mean change "modebuf" to "iftypebuf" or
> something else.

Yes. Agree with you. This leads to a confusion.

I will change to *iftypebuf*. V2 is on the way.

Thanks

> I can understand "Unknown mode" is confusing. But to handle now "iftypeFOO"
> and "modeFOO" is more confusing than before.
>
> - Alex

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

