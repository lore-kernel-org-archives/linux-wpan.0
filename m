Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33636 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGFXXL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jul 2019 19:23:11 -0400
References: <20190624144757.1285-1-colin.king@canonical.com>
 <B6A1CB42-C239-42CA-B14E-483A02B930EB@holtmann.org>
From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH][next] 6lowpan: fix off-by-one comparison of index id with
 LOWPAN_IPHC_CTX_TABLE_SIZE
Message-ID: <f09c07d6-9a16-3acf-dd07-4b7bfcd732f3@canonical.com>
Date: Sun, 7 Jul 2019 00:23:07 +0100
MIME-Version: 1.0
In-Reply-To: <B6A1CB42-C239-42CA-B14E-483A02B930EB@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/07/2019 11:51, Marcel Holtmann wrote:
> Hi Colin,
> 
>> The WARN_ON_ONCE check on id is off-by-one, it should be greater or equal
>> to LOWPAN_IPHC_CTX_TABLE_SIZE and not greater than. Fix this.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>> net/6lowpan/debugfs.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
>> index 1c140af06d52..a510bed8165b 100644
>> --- a/net/6lowpan/debugfs.c
>> +++ b/net/6lowpan/debugfs.c
>> @@ -170,7 +170,7 @@ static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
>> 	struct dentry *root;
>> 	char buf[32];
>>
>> -	WARN_ON_ONCE(id > LOWPAN_IPHC_CTX_TABLE_SIZE);
>> +	WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE);
> 
> this patch no longer applied cleanly to bluetooth-next. Can you send me an updated version.

I'm confused by this, I just applied it OK on bluetooth-next [1] on the
head 9ce67c3235be71e8cf922a9b3d0b7359ed3f4ce5, am I applying this to the
wrong repo/branch?

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git


Colin

> 
> Regards
> 
> Marcel
> 
