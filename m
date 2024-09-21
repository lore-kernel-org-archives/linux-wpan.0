Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E821208D0;
	Sat, 21 Sep 2024 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726896856; cv=none; b=DQE/mtlCy7geIHb9q20/yjxItK5mDGukmCtHC3PIQEsuyA9Qz/puhwwAfjgSeig7fwkafLGZ1mwbXxCIcDC+XvpSHLPZPfjDnhLF1EJERiMmeA2dagMTTz37HV3ipHePGTjqj3wyi4q+uGeYQmdGpA3jtvMbY/weilYW8SFq1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726896856; c=relaxed/simple;
	bh=3FZABDyrH3jSYvk21qabLqPxXVeuvpt2j06Mn3yPzoQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQNKsJ6KlQb//iEKS6s0/1dZsUm18dVGxTRf3gX5Azn0f8Fokto0jH1pMeMqDEyJCLaIUadR06ok5R2cbeoCB6VmOBWqm7JD5WY0J+ldkZ8RNQwPgHO8SNfSDU9Ga2Gx6hb1FcRA07poYPw5pc9wKYLxmYNPi6ggEbgoXR4UyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ltTj6hOA; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ltTj6hOA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1726896547;
	bh=bYRV2wnJ3CUDym9ZHBOkFYYV9lkxtJ1zt2t6FLcsLNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ltTj6hOA69oJ6j2+OzFMUK1GUioPgSGjrX6yiTuov94IAtRoiwY9xY/jAorDLAgNZ
	 OuqlPYGloVEHnsnxtwAyHkapzeNgNuyrIUkNEBNUnOSID0l/dRXQL3QixcrjitPp+5
	 UCYTykCOvjJx19UCC1cAmwbkdac90whApdN1sshw=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 5B0B604D; Sat, 21 Sep 2024 13:22:48 +0800
X-QQ-mid: xmsmtpt1726896168tsf0h70fw
Message-ID: <tencent_51492FE7A9204AE5B3DC49FA4F144D310F08@qq.com>
X-QQ-XMAILINFO: N8ZpjUAx43dLkhxkD+DGecE3uZmnEGJC+r7MEtKp5GqsygRKPTDfF3AZ2zEDUd
	 dzeDUFUHvGS3q6MlCu6mF9Lbt6+oBV3vxQ6EwNyO4TvFjK79qnJKNeAo0CF3Y1YjXot99rMrhZH1
	 SDGXDIW6urnsD/MVVIafjhB6tvvKSUnJ+ekmpqVv1kmKHF3QFBLA5SHwqf+EnopCGvtxzsIm/QWN
	 yBoHrohAruTkJKY9RhIlncf4fcKPcbiD76OrPLasUUb/ZCvxbnZsUrDSIwbVpJGQJ/t5YHc7YJQe
	 yDwyUr3V+9UfRJ1B2VsKIToGbMQibxX3MVlrvpRJXJ8Mlso7VjVfqzxVSRJND1uABBrjip2HHYk1
	 1/XcU+tiiWXtdMBTI4PWb7W8APYvEyh7D8UkhB1NuTc0IoDviMe/Y8qeC9XCQioNcmUNAi9d8Qg2
	 rwg/E0/LCox9bRBIo4tdOoq69jYfSrQL41sIlXvM6tEB5BGUjZ1bG7iHYnSqyBxlVRNq5x3D+3kR
	 RKiXyYza8Y1yvdLWkUZB+2pk78ddyqC0BFRfj0EdvW2nA+CEORiWC6cLaaNGDcXk+Y/M0HZNqy8l
	 DsAP6r0BFuujPQytcI/W0LVdwO7yhpDLqPy+q1U+finUwhcCCAkY4aV6jeCaCaDuS4PKmcZgQ+HJ
	 SHkc9dEeINkCmIbAjWy9I0PvJFFUwHQmChDo1BfJIWU/y1mFC63gWVFhX0vshv0dJD6nDC8+FaFg
	 Hwresam1C96g/Z6GsHHTTtlHxn3y+OHuuGhVx2YcSopWn9tTEK+69wIiaFPvFb1kpCqkyvlbZfRt
	 v3dyoK1DAwmVtTLD8OnDx1zq5Lnv7G4UrwPk5TCiB5s8wYIOf2rCCuDQuXwCvm5avOJsaL4je3vK
	 dVJeeVoSMdeWqxGSvioMW2wCRS2W7nQj7KR93Yd+DPJypzwLTPvtAjX7LvaAgz6DhJ0q2Nvk7m58
	 ijOAN6peXT/Mcj81vKiR7MXJPqvoZdrX70jlCiA7fAzBXK5g2kbNf/8HixsaxHTT0emvdinLrr7s
	 dAsemUH+kWRO8R7nNnEyHWX5KX5Hnrh0iF1KDWOIvSKz2mqffFW3MS2NTVXNgCFqRBOwH/1G3+tW
	 yT9tVSI+qf72XHUWeF7BiP/2q1jTESRfSsz33r1nFxkvgQir2f6+f3qOusrCGNCLVafHh0oDcZoR
	 +ttbE1BEqAJinCJQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: miquel.raynal@bootlin.com
Cc: alex.aring@gmail.com,
	davem@davemloft.net,
	david.girault@qorvo.com,
	edumazet@google.com,
	jiawei.ye@foxmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	stefan@datenfreihafen.org
Subject: Re: [PATCH v2] mac802154: Fix potential RCU dereference issue in mac802154_scan_worker
Date: Sat, 21 Sep 2024 05:22:48 +0000
X-OQ-MSGID: <20240921052248.3386758-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240920132131.466e5636@xps-13>
References: <20240920132131.466e5636@xps-13>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Miquèl,

I'm sorry for the accidental email sent while testing my email setup. Please disregard the previous message.

On 9/20/24 19:21, Miquel Raynal wrote:
> Hi Jiawei,
> 
> jiawei.ye@foxmail.com wrote on Fri, 20 Sep 2024 04:03:32 +0000:
> 
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
> 
> I think net maintainers now expect the Cc: stable tag to be put here
> when there is a reason to backport, which I believe is the case here.
> So please add this line here.
> 

Does this mean I should use Cc: stable@vger.kernel.org? I am not familiar with this procedure.

> > 
> 
> Please delete this blank line as well.
> 
> And with that you can add my:
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> > ---
> 
> Thanks,
> Miquèl

Do I need to resend patch v2 with the "Resend" label?

Thank you for your assistance.

Best regards,
Jiawei Ye

