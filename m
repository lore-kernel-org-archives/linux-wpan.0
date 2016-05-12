Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48258 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793AbcELATm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 20:19:42 -0400
Subject: Re: [PATCH wpan-tools 2/2] phy: add netns support
References: <1462959979-6755-1-git-send-email-aar@pengutronix.de>
 <1462959979-6755-2-git-send-email-aar@pengutronix.de>
 <57334C01.90500@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <f6afa503-746a-175b-5163-f43e18bcd6b2@pengutronix.de>
Date: Thu, 12 May 2016 02:19:40 +0200
MIME-Version: 1.0
In-Reply-To: <57334C01.90500@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de


Hi,

On 05/11/2016 05:13 PM, Stefan Schmidt wrote:
> Hello.
> 
> Quick tip. If you want to check your code with coverity before putting it into master you can push it to the branch coverty_scan on github and travis will build and submit it to coverity. I find this handy when doing new code to check it before putting it into master. Nothing wrong with this code just a tip. :)
> 

ok, I will try it put don't be angry if everything is broken afterwards.
:-)

> On 11/05/16 11:46, Alexander Aring wrote:
>> This patch adds netns support, basically most parts are copy&pasted from
>> iw tool, same handling just wpan instead wireless.
>>
>> Signed-off-by: Alexander Aring <aar@pengutronix.de>
>> ---
>>   src/phy.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>
>> diff --git a/src/phy.c b/src/phy.c
>> index 816bdd8..887b610 100644
>> --- a/src/phy.c
>> +++ b/src/phy.c
>> @@ -2,6 +2,10 @@
>>   #include <errno.h>
>>   #include <string.h>
>>   #include <stdbool.h>
>> +#include <sys/param.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>>     #include <netlink/genl/genl.h>
>>   #include <netlink/genl/family.h>
>> @@ -144,3 +148,65 @@ nla_put_failure:
>>   }
>>   COMMAND(set, cca_ed_level, "<level>",
>>       NL802154_CMD_SET_CCA_ED_LEVEL, 0, CIB_PHY, handle_cca_ed_level, NULL);
>> +
>> +#ifndef NETNS_RUN_DIR
>> +#define NETNS_RUN_DIR "/var/run/netns"
>> +#endif
>> +int netns_get_fd(const char *name)
> Make this function static?
> 

ok.

- Alex
