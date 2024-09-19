Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620C19B3C5;
	Thu, 19 Sep 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749093; cv=none; b=BOs54p1jUE4CQTaXwYYd632uJ44+T2K+ICOMiISxUDQ6Ohq3p4bjm5+msGPG1Mtr3NXPu44M3snewmmMemVPmoKLHfDiPxF/TQm2evx6G5l429zZvekiSmSPgZd0ZGXApi81EWMVoUD3a8VbHIuOQDn4InUdkV+Hyr8tLAEuuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749093; c=relaxed/simple;
	bh=V+T0Pu2P42+FAOgyBvdWJNXdBMvCqGs3O9XO4cJXROk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=goD7s9UOZTKJchDFYiAmOwJ/dD9beuVYLbKDweA6W1M0eOAd0Q8AztA+4v2ffDGzLEKqaXa3DOcqlucTYe2lXyE8Dk/mXLkPluCerbi7BSbtd90wF3ZXxFCgtOcaQW5oWYPdBnoHoGbB3/dtMGWFJeftjw4MfxNSbbmWGwYkQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xyDzsdw2; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xyDzsdw2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1726748781;
	bh=Ugf04+8SH5clAs9zJB1Rtjp8akqAeiWsHmjBZsQxOh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xyDzsdw2RNezgXbpb8Vx3CdYNcdvcW4Shk0pwOdY6LX2tf4OV0kwU8JbcedTb1VpO
	 91Wk//OIgZMNdNSaqR7wjr83daZvTu00Bkhzx4NNZ6TM5pqo5zsjhlYfWd1hUuqxJj
	 7eaTjPFVTwLC/z5O39d8z5AO5M1RT4/8lfU5B6vw=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 69205012; Thu, 19 Sep 2024 20:26:18 +0800
X-QQ-mid: xmsmtpt1726748778tiu3ik25l
Message-ID: <tencent_8C653C3534893CF0BC88A43A2831CDA2260A@qq.com>
X-QQ-XMAILINFO: NA8WCMn5GQiMadq4APsyVXge7vikEiAl3jr0qOtnpDBMuNQJ+ZbuMqXIuW2m3H
	 ER1FQ2M7I/+VDzgxrkXACFvVyrWc7NM9Z14uepgwGPefC1ZH7AEI/Zhizsp60JWO4+FRvCDQi8QK
	 uy7sGLbsCbiHTxdeLkE8E93FuayyiYVVc0LO68AtzxdiReJZzUrA9LIFjtnbVF3ktqFFLugWuLL/
	 7jZ8SMMydnC0gHQrZut4lf13xDQMftQqX1lSr0rx9UR5A5eELqGtsKhrihloNBJmwsXRvcOVhdvz
	 iZOuKN2laS+nPlntMe0nXWAnoAmpvSKO348ZIQ+sIH1xASzttzc5XZ6ViidkFw/UaqYB53960Nc9
	 RQNZ3slH0swhCxfZn6S2xqV8F+DWkqTMXE3IEpp2nQw9FjTMKAvDakAIQlSRlJo0vSNp7hrlhnHj
	 YXGhTTkRBYn0CxK01d/y9S7tT5w2tky5s5+lpwBnk/5WcoabuFMv/qG4hCMBTl4imY0IFw7eBV9O
	 ypP/xQHypRnWa5yEeVHOVaRtgvc9y2LLd+GG+TDMN/NZDZsfpqHGYQgMaLm4uqnGlAJ5wAhw+5yU
	 FedszXGKJ9HmzUpsATJchdYo1ANXSHhlpY1CW6gWjg/MdeoK8AxA/R31QlY9EqEHIyNUqv3SnpFl
	 X+0h7kBPwKR6Ju4B+ibUiybaGV3bVB2l0wUD3/XmsklyCAKgTiyW6b10XWSHUdscHmKoIs4/FIsK
	 5ZPC2Szrkh7zveexzliLUrMNZ/apTGOnKv2FAB2B1kWtO4VsVbRYxp7Z0t9CigU5zs++MB4E55cl
	 KksHkRz3BZuHF6MLUVrTAUT3T31ghDHVYeGhaT0JoJWsDM78KxgvcSzVU044+9Geb70Nmdp2B5h6
	 Q835+fLgXTHFx2kgY3vQJSweJ3odaWzZrU15F4CagKPbTvZBvWwX+/DoVP43TJJ2yA/Ojrx7jfTI
	 AgqyoK58GvYZRYdRZpoQUOGFr2PgZ56jovIGLLIk+vn2oFqJ551EqLzq3D3Ja2q+gt1fScARbdEw
	 vWbfqJS2oQNsrF+lDxb/H6WaE2MIESMvRTKT62SCScSWLoafLYt48H1Jd3Z8IFeOeqa0ig/3E9bM
	 NcTeFDvptQDND5gtxXya9A6y3uzw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: przemyslaw.kitszel@intel.com
Cc: alex.aring@gmail.com,
	davem@davemloft.net,
	david.girault@qorvo.com,
	edumazet@google.com,
	jiawei.ye@foxmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stefan@datenfreihafen.org
Subject: Re: [PATCH] Fix the RCU usage in mac802154_scan_worker
Date: Thu, 19 Sep 2024 12:26:17 +0000
X-OQ-MSGID: <20240919122617.1169865-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f3c26426-7ebb-4b8b-9443-f604292a53a9@intel.com>
References: <f3c26426-7ebb-4b8b-9443-f604292a53a9@intel.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/19/24 17:01, Przemek Kitszel wrote:
> > In the `mac802154_scan_worker` function, the `scan_req->type` field was
> > accessed after the RCU read-side critical section was unlocked. According
> > to RCU usage rules, this is illegal and can lead to unpredictable
> > behavior, such as accessing memory that has been updated or causing
> > use-after-free issues.
> > 
> > This possible bug was identified using a static analysis tool developed
> > by myself, specifically designed to detect RCU-related issues.
> > 
> > To address this, the `scan_req->type` value is now stored in a local
> > variable `scan_req_type` while still within the RCU read-side critical
> > section. The `scan_req_type` is then used after the RCU lock is released,
> > ensuring that the type value is safely accessed without violating RCU
> > rules.
> > 
> > Fixes: e2c3e6f53a7a ("mac802154: Handle active scanning")
> > Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
> > ---
> >   net/mac802154/scan.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> > index 1c0eeaa76560..29cd84c9f69c 100644
> > --- a/net/mac802154/scan.c
> > +++ b/net/mac802154/scan.c
> > @@ -180,6 +180,7 @@ void mac802154_scan_worker(struct work_struct *work)
> >   	unsigned int scan_duration = 0;
> >   	struct wpan_phy *wpan_phy;
> >   	u8 scan_req_duration;
> > +	enum nl802154_scan_types scan_req_type;
> 
> this line violates the reverse X-mass tree rule of code formatting

Thank you for pointing out the concern regarding the violation of the
reverse Christmas tree rule. I will adjust the placement of 
`enum nl802154_scan_types scan_req_type` to be between 
`struct cfg802154_scan_request *scan_req` and 
`struct ieee802154_sub_if_data *sdata`. If this change is suitable,
should I resend the patch as a v2 patch?

> 
> >   	u8 page, channel;
> >   	int ret;
> >   
> > @@ -210,6 +211,7 @@ void mac802154_scan_worker(struct work_struct *work)
> >   
> >   	wpan_phy = scan_req->wpan_phy;
> 
> this line (not yours) just saves the first level of pointer, but then
> accesses wpan_phy->... outside of the rcu_read_lock() section, for me
> it's very similar case to what you are fixing here
> 

According to the RCU usage rules, the value returned by `rcu_dereference()`
should be safely dereferenced only within the RCU read-side critical
section. It is important to note that `wpan_phy` is not obtained through
`rcu_dereference()`, so in this context, it may not be sufficient to infer
whether it is protected by RCU.

> >   	scan_req_duration = scan_req->duration;
> > +	scan_req_type = scan_req->type;
> >   
> >   	/* Look for the next valid chan */
> >   	page = local->scan_page;
> > @@ -246,7 +248,7 @@ void mac802154_scan_worker(struct work_struct *work)
> >   		goto end_scan;
> >   	}
> >   
> > -	if (scan_req->type == NL802154_SCAN_ACTIVE) {
> > +	if (scan_req_type == NL802154_SCAN_ACTIVE) {
> >   		ret = mac802154_transmit_beacon_req(local, sdata);
> >   		if (ret)
> >   			dev_err(&sdata->dev->dev,

